ruby '2.7.2'

source 'https://rubygems.org'

gem 'image_processing', '~> 1.12'
gem 'rack', '~> 2.2'
gem 'rack-host-redirect', '~> 1.3'
gem 'rack-ssl-enforcer', '~> 0.2.9'
gem 'sinatra', '~> 2.0'
gem 'sinatra-asset-pipeline', '~> 2.2', require: 'sinatra/asset_pipeline'

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
  gem 'shotgun'
end

group :test do
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end
