ruby '2.6.2'

source 'https://rubygems.org'

gem 'image_processing', '~> 1.8'
gem 'puma', '~> 3.12'
gem 'rack-host-redirect', '~> 1.3'
gem 'rack-ssl-enforcer', '~> 0.2.9'
gem 'sinatra', '~> 2.0', '>= 2.0.5'
gem 'sinatra-asset-pipeline', '~> 2.2', require: 'sinatra/asset_pipeline'
gem 'sinatra-param', git: 'https://github.com/jgarber623/sinatra-param', tag: 'v2.0.0'

group :development, :test do
  gem 'rack-test', '~> 1.1'
  gem 'rake', '~> 12.3', '>= 12.3.2'
  gem 'rspec', '~> 3.8'
  gem 'rubocop', '~> 0.65.0', require: false
  gem 'rubocop-rspec', '~> 1.32', require: false
end

group :development do
  gem 'shotgun', '~> 0.9.2'
end

group :test do
  gem 'simplecov', '~> 0.16.1', require: false
  gem 'simplecov-console', '~> 0.4.2', require: false
end
