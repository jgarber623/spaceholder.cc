require File.expand_path('config/environment', __dir__)
require 'rspec/core/rake_task'
require 'sinatra/asset_pipeline/task'

RSpec::Core::RakeTask.new

Sinatra::AssetPipeline::Task.define! Spaceholder::App

task default: :spec
