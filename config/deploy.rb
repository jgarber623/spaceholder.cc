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

default_run_options[:shell] = '/bin/bash'

namespace :deploy do
  task :restart do
    run "sh #{shared_path}/puma_restart.sh"
  end

  task :start do
    run "sh #{shared_path}/puma_start.sh"
  end

  task :stop do
    run "sh #{shared_path}/puma_kill.sh"
  end
end
