namespace :edx do
  task courses: [:environment, :init_grabber] do
    platform = Platform[:edx]

    grabber = init_grabber
    grabber.get platform.url
    grabber.page.link_with(:text => 'Find Courses').click
    courses = grabber.page.search('article.course')
    courses.each do |course_xml|
      course_hash ={}
      url = platform.url + course_xml.css('> a').attr('href').value
      course_hash[:title] = course_xml.css('h2').text
      course_hash[:logo_url] = change_https_to_http(platform.url) + course_xml.css('.cover-image > img').attr('src')
      course_hash[:description] = course_xml.css('.desc').text.squish
      course_hash[:start_date] = Date.parse course_xml.css('.start-date').text
      course_hash[:platform] = platform

      course = Course.find_or_create_by_url url, course_hash

      grabber.get course.url
      register_link = grabber.page.at("a.register")
      if register_link
        grabber.page.forms.first.submit
      end

    end

    puts "#{Course.count} courses grabbed"
  end
end
