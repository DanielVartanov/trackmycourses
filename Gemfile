source 'https://rubygems.org'

gem 'rails', '3.2.8'

gem 'backbone-on-rails'
gem 'jquery-rails'
gem 'slim'
gem 'jbuilder'
gem 'mechanize'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'thin'

group :development do
  gem 'nokogiri-pretty'
  gem 'hirb'
  gem 'sqlite3'
  # Deploy with Capistrano
  gem 'capistrano'
  gem 'rvm-capistrano'
  gem 'capistrano-unicorn'
end

group :test do
  gem 'rspec-rails'
  gem 'database_cleaner'
end

group :test, :development do
  gem 'debugger'
end

group :production do
  gem 'pg'
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
  gem 'zurb-foundation', '~> 3.0.9'
  gem 'ejs', '1.0.0'
end

