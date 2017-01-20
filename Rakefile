require 'sinatra/asset_pipeline/task'
require './app'

Sinatra::AssetPipeline::Task.define! SpaceHolder

if ENV['RACK_ENV'] != 'production'
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new do |task|
    task.options << '--display-cop-names'
  end
end
