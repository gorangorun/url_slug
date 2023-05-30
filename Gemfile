# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in url_slug.gemspec
gemspec

gem 'activesupport'
gem 'thor'

group :development do
  gem 'rake', '~> 13.0'
end

group :development, :test do
  gem 'byebug'
  gem 'rspec', '~> 3.0', require: false
  gem 'rubocop', '~> 1.21', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'i18n', '~> 1.13', require: false
end
