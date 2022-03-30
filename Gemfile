# frozen_string_literal: true

ruby '3.1.1'

source 'https://rubygems.org'

gem 'image_processing'
gem 'puma'
gem 'rack'
gem 'roda'
gem 'roda-sprockets'
gem 'sassc'
gem 'tilt'

group :development, :test do
  gem 'bundler-audit'
  gem 'rack-test'
  gem 'rake'
  gem 'reek', require: false
  gem 'rspec'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'rerun'
end

group :test do
  gem 'rspec-github', require: false
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end
