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
