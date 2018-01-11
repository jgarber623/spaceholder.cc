ruby '2.4.2'

source 'https://rubygems.org' do
  gem 'mini_magick', '~> 4.8'
  gem 'puma', '~> 3.11'
  gem 'sinatra', '~> 1.4', '>= 1.4.8'
  gem 'sinatra-asset-pipeline', '~> 0.7.0', require: 'sinatra/asset_pipeline'

  group :development do
    gem 'capistrano', '~> 3.10', '>= 3.10.1'
    gem 'capistrano-bundler', '~> 1.3'
    gem 'capistrano-chruby', '~> 0.1.2'
    gem 'rake', '~> 10.5'
    gem 'rubocop', '~> 0.52.1', require: false
    gem 'shotgun', '~> 0.9.2'
  end
end
