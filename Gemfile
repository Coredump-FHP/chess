source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap-sass', '~> 3.3.5.1'
gem 'coffee-rails', '~> 4.2'
gem 'devise', '>= 3.2.4'
gem 'figaro'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'omniauth-facebook'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.1'
gem 'rails_12factor', group: :production
gem 'rubocop', '~> 0.47.1', require: false
gem 'sass-rails'
gem 'simple_form'
gem 'sprockets', '~> 3.0'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'pry', '~> 0.10.3'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.5'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
