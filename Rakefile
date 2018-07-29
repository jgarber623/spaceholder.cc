require File.expand_path('config/environment', __dir__)
require 'sinatra/asset_pipeline/task'

Sinatra::AssetPipeline::Task.define! Spaceholder::App

unless ENV['RACK_ENV'] == :production
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new

  task default: :spec
end
