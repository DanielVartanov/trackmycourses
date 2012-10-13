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

# grabber.page.search("article.my-course > a").first
# courses
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

    grabber.page.search('ol.chapters > li').each do |chapter_xml|
      chapter = Chapter.new course: course
      chapter.title = chapter_xml.css('h2').text.squish
      chapter.save

      section = chapter_xml.css('ol.sections > li').each do |section_xml|
        section = Section.new chapter: chapter
        section.url = platform.url + section_xml.css('h3 > a').attr('href').value
        section.title = section_xml.css('h3 > a').text.squish
        exercise_count_matched = section_xml.css('h3 > span').text.match(/\/(\d+)/).to_a
        section.exercise_count = exercise_count_matched[1] if exercise_count_matched.any?
        section_due_date_string = section_xml.css('p > em').text
        begin
          section.due_date = DateTime.parse section_due_date_string if section_due_date_string
        rescue ArgumentError
          p "DateTime parse: #{section_due_date_string}"
        end
        section.save
      end
    end
  end
end
