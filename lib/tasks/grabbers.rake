def change_https_to_http(url)
  parsed_uri = URI.parse(url)
  parsed_uri.scheme = 'http'
  parsed_uri.to_s
end

namespace :grab do
  desc 'Grab course list'
  task courses: :environment do
    platform = Platform[:edx]

    grabber = Mechanize.new
    grabber.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    grabber.get platform.url
    grabber.page.link_with(:text => 'Find Courses').click
    courses = grabber.page.search('article.course')
    courses.each do |course_xml|
      course = Course.new platform: platform
      course.url = platform.url + course_xml.css('> a').attr('href').value
      course.title = course_xml.css('h2').text
      course.logo_url = change_https_to_http(platform.url) + course_xml.css('.cover-image > img').attr('src')
      course.description = course_xml.css('.desc').text.squish
      course.start_date = Date.parse course_xml.css('.start-date').text
      course.save!
    end

    puts "#{Course.count} courses grabbed"
  end

  desc 'Grab courses internals'
  task internals: :environment do
    platform = Platform[:edx]

    grabber = Mechanize.new
    grabber.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    grabber.get platform.url
    form = grabber.page.form_with(id: 'login_form')
    form.email = platform.credentials[:email]
    form.password = platform.credentials[:password]
    csrf_token = grabber.cookie_jar.jar['www.edx.org']['/']['csrftoken'].value
    grabber.request_headers['X-CSRFToken'] = csrf_token
    grabber.submit(form)

    grabber.get '/dashboard'

    courses = grabber.page.search("article.my-course > a").map {|course| {url: course.attr('href'), title: course.css('h3').text} }

    courses.each do |course_info|
      course = Course.find_by_title course_info[:title]
      if course.started?

        grabber.get course_info[:url]
        begin
          grabber.page.link_with(text: 'Progress').click
        rescue NoMethodError
          continue
        end

        grabber.page.search('ol.chapters > li').each_with_index do |chapter_xml, index|
          chapter = Chapter.new course: course
          chapter.title = chapter_xml.css('h2').text.squish
          chapter.number = index + 1
          chapter.save

          section = chapter_xml.css('ol.sections > li').each do |section_xml|
            section = Section.new chapter: chapter
            section.url = platform.url + section_xml.css('h3 > a').attr('href').value
            section.title = section_xml.css('h3 > a').text.squish
            exercise_count_matched = section_xml.css('h3 > span').text.match(/\/(\d+)/).to_a
            section.score_count = exercise_count_matched[1] if exercise_count_matched.any?
            section.exercise_count = section_xml.css('.scores > ol > li').count
            section_due_date_string = section_xml.css('p > em').text
            begin
              section.due_date = DateTime.parse section_due_date_string if section_due_date_string
            rescue ArgumentError
            end
            section.save
          end
        end
      end
    end
    puts "#{Chapter.count} chapters grabbed"
    puts "#{Section.count} sections grabbed"
  end
end

namespace :db do
  desc 'Recreate database and populate with course info'
  task :populate do
    Rake::Task['db:reset'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['grab:courses'].execute
    Rake::Task['grab:internals'].execute
  end
end
