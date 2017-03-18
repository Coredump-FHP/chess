source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Bootstrap
gem 'bootstrap-sass', '~> 3.3.5.1'
gem 'sass-rails'
gem 'sprockets', '~> 3.0'

# devise
gem 'devise', '>= 3.2.4'

# OmniAuth with facebook provider
gem 'figaro'
gem 'omniauth-facebook'

# Simpleform integreated
gem 'simple_form'
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# use rubocop for Ruby style guide.
gem 'rubocop', '~> 0.47.1', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get
  # a debugger console
  gem 'byebug', platform: :mri
  gem 'database_cleaner'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.5'
  gem 'selenium-webdriver'
end

group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'poltergeist'
  gem 'simplecov', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %>
  # anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
