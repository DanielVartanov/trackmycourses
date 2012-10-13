Course.delete_all

platform = Platform[:edx]

grabber = Mechanize.new
grabber.get platform.url
grabber.page.link_with(:text => 'Find Courses').click
courses = grabber.page.search('article.course')
courses.each do |course_xml|
  course = Course.new platform: platform
  course.url = platform.url + course_xml.css('> a').attr('href').value
  course.title = course_xml.css('h2').text
  course.logo_url = platform.url + course_xml.css('.cover-image > img').attr('src')
  course.description = course_xml.css('.desc').text.squish
  course.save!
end

puts Course.all.inspect
