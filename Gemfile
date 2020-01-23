ruby '2.6.5'

source 'https://rubygems.org'

gem 'image_processing', '~> 1.10'
gem 'rack', '~> 2.1'
gem 'rack-host-redirect', '~> 1.3'
gem 'rack-ssl-enforcer', '~> 0.2.9'
gem 'sinatra', '~> 2.0'
gem 'sinatra-asset-pipeline', '~> 2.2', require: 'sinatra/asset_pipeline'

group :development, :test do
  gem 'rack-test', '~> 1.1'
  gem 'rake', '~> 12.3'
  gem 'reek', '~> 5.6', require: false
  gem 'rspec', '~> 3.9'
  gem 'rubocop', '~> 0.79.0', require: false
  gem 'rubocop-performance', '~> 1.5', require: false
  gem 'rubocop-rspec', '~> 1.37', require: false
end

group :development do
  gem 'shotgun', '~> 0.9.2'
end

group :test do
  gem 'simplecov', '~> 0.17.1', require: false
  gem 'simplecov-console', '~> 0.6.0', require: false
end
