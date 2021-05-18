source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.1'
gem 'pg'
gem 'puma', '~> 4.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

gem 'devise'
gem 'devise_invitable'
gem 'haml-rails'
gem 'carrierwave'
gem 'jquery-rails'
gem 'select2-rails'
gem 'font-awesome-rails'
gem 'bootstrap'
gem 'friendly_id'
gem 'pundit'
gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'bugsnag', '~> 6.7'
gem 'addressable'

gem 'wicked_pdf', '~> 1.1'
gem 'wkhtmltopdf-binary'


# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
  gem 'letter_opener'
  gem 'bullet'

  gem 'capistrano', require: false
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-rails', require: false
end

group :test do
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'simplecov', require: false
  gem 'shoulda-matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]