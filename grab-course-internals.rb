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

course = grabber.page.search("article.my-course > a").first
course_url = course.attr('href')
grabber.get course_url
grabber.page.link_with(text: 'Progress').click

week = grabber.page.search('ol.chapters > li')[1]

section = week.css('ol.sections > li').first
lecture_exercises_count = section.css('h3 > span').text.match(/\/(\d+)/)[1]

lecture_name = section.css('h3 > a').text.squish
