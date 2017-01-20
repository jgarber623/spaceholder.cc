require 'rubocop/rake_task'
require 'sinatra/asset_pipeline/task'
require './app'

RuboCop::RakeTask.new do |task|
  task.options << '--display-cop-names'
end

Sinatra::AssetPipeline::Task.define! SpaceHolder
