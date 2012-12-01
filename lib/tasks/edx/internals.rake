def change_https_to_http(url)
  parsed_uri = URI.parse(url)
  parsed_uri.scheme = 'http'
  parsed_uri.to_s
end

namespace :edx do
  task internals: [:environment, "edx:init_grabber"] do
    grabber = init_grabber
    platform = Platform[:edx]

    grabber.get '/dashboard'

    courses = grabber.page.search("article.my-course > a").map {|course| {url: course.attr('href'), title: course.css('h3').text} }

    courses.each do |course_info|
      course = Course.find_by_title course_info[:title]
      if course.started?

        grabber.get course_info[:url]
        begin
          grabber.page.link_with(text: 'Progress').click
        rescue NoMethodError
          next
        end

        grabber.page.search('ol.chapters > li').each_with_index do |chapter_xml, index|
          chapter_title = chapter_xml.css('h2').text.squish
          chapter = Chapter.where(course_id: course).find_or_create_by_title chapter_title, number: index + 1

          chapter_xml.css('ol.sections > li').each do |section_xml|
            section_url = change_https_to_http(platform.url) + section_xml.css('h3 > a').attr('href').value
            section_title = section_xml.css('h3 > a').text.squish
            exercise_count_matched = section_xml.css('h3 > span').text.match(/\/(\d+)/).to_a
            section_score_count = exercise_count_matched[1] if exercise_count_matched.any?
            section_practice_count = section_xml.css('.scores > ol > li').count
            section_due_date_string = section_xml.css('p > em').text
            section_duration = 0

            begin
              section_due_date = DateTime.parse section_due_date_string if section_due_date_string
            rescue ArgumentError
              section_due_date = ""
            end

            if section_due_date.blank?
              Lecture.find_or_create_by_url section_url,
                practice_count: section_practice_count,
                duration: section_duration,
                title: section_title,
                score_count: section_score_count,
                chapter: chapter,
                duration: -1

            else
              Assignment.find_or_create_by_url section_url, 
                due_date: section_due_date,
                title: section_title,
                chapter: chapter
            end

          end
        end
      end
    end
    puts "#{Chapter.count} chapters grabbed"
    puts "#{Lecture.count} lectures grabbed"
    puts "#{Assignment.count} assignments grabbed"
  end
end
