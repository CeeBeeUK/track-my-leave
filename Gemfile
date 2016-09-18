source 'https://rubygems.org'
gem 'dotenv-rails', groups: [:development, :test] # this has to be here because of load order
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
gem 'pundit'
gem 'omniauth-google-oauth2', '~> 0.2.1'
gem 'config'
gem 'slim-rails'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'rubocop', require: true
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard-livereload'
  gem 'terminal-notifier-guard'
end

group :test do
  gem 'codeclimate-test-reporter', require: nil
  gem 'shoulda-matchers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
