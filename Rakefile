lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

env = (ENV['RACK_ENV'] || 'development').to_sym

require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, env)

require 'sinatra/asset_pipeline/task'
require 'spaceholder'

Sinatra::AssetPipeline::Task.define! Spaceholder::App
