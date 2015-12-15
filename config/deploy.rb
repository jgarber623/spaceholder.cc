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
set :normalize_asset_timestamps, false

set :ruby_version, '2.2.3'
set :bundle_cmd, "chruby-exec #{ruby_version} -- bundle"

default_run_options[:shell] = '/bin/bash'

before 'deploy:create_symlink', 'deploy:precompile_assets'

namespace :deploy do
  task :precompile_assets do
    run "cd #{release_path} && RACK_ENV=production #{bundle_cmd} exec rake assets:precompile"
  end

  %w[start stop restart].each do |command|
    task command do
      # Sort this out…
    end
  end
end
