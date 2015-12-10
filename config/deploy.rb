set :stages, %w(production)
set :default_stage, 'production'

require 'bundler/capistrano'
require 'capistrano/ext/multistage'

set :application, 'spaceholder.cc'

set :repository, 'git@github.com:jgarber623/spaceholder.cc.git'
set :deploy_to, '/var/www/spaceholder-cc'
set :user, 'www-data'
set :deploy_via, :remote_cache
set :ssh_options, { forward_agent: true }
set :use_sudo, false

set :ruby_version, '2.2.3'
set :bundle_cmd, "chruby-exec #{ruby_version} -- bundle"
set :pumactl_cmd, "#{bundle_cmd} exec pumactl -F config/puma.rb"

default_run_options[:shell] = '/bin/bash'

namespace :deploy do
  task :restart do
    run "cd #{current_path} && #{pumactl_cmd} restart"
  end

  task :start do
    run "cd #{current_path} && #{pumactl_cmd} start"
  end

  task :stop do
    run "cd #{current_path} && #{pumactl_cmd} stop"
  end
end
