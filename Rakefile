require File.expand_path('config/environment', __dir__)
require 'sinatra/asset_pipeline/task'

Sinatra::AssetPipeline::Task.define! Spaceholder::App

unless ENV['RACK_ENV'] == 'production'
  require 'reek/rake/task'
  require 'rspec/core/rake_task'
  require 'rubocop/rake_task'

  Reek::Rake::Task.new do |task|
    task.fail_on_error = false
  end

  RSpec::Core::RakeTask.new

  RuboCop::RakeTask.new do |task|
    task.fail_on_error = false
  end

  task default: [:rubocop, :reek, :spec]
end
