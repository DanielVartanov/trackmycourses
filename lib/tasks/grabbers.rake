namespace :grab do
  desc "Grab all platforms"
  task all: ["edx:all"]

  desc "Grab edx"
  task edx: "edx:all"

  desc "Grab coursera"
  task coursera: "coursera:all"
end

namespace :edx do

  task all: ["edx:courses", "edx:internals", "edx:video"]

  task init_grabber: :environment do
    def init_grabber
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
      grabber
    end
  end
end


namespace :db do
  desc 'Recreate database and populate with course info'
  task :populate do
    Rake::Task['db:reset'].invoke
    Rake::Task['db:seed'].invoke
    Rake::Task['grab:all'].invoke
  end
end
