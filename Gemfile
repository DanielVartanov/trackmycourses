source 'https://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'thin'

group :development do
  gem 'mechanize'
  gem 'nokogiri-pretty'
  gem 'hirb'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'capybara-webkit'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
  gem 'compass-rails', '~> 1.0.3'
  gem 'zurb-foundation', '~> 3.1.1'
  gem 'ejs', '1.0.0'
end

gem 'backbone-on-rails'
gem 'jquery-rails'
gem 'slim'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
gem 'jbuilder'

group :production do
  # Use unicorn as the app server
  gem 'unicorn'
end

group :development do
  gem 'debugger'
  # Deploy with Capistrano
  gem 'capistrano'
  gem 'rvm-capistrano'
  gem 'capistrano-unicorn'
end
