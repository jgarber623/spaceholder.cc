set :stages, %w(production)
set :default_stage, 'production'

require 'bundler/capistrano'
require 'capistrano/ext/multistage'

set :application, 'spaceholder.cc'
set :deploy_to, '/var/www/spaceholder-cc'
set :repository, 'git@github.com:jgarber623/spaceholder.cc.git'
set :user, 'www-data'

set :deploy_via, :remote_cache
set :normalize_asset_timestamps, false
set :ssh_options, forward_agent: true
set :use_sudo, false

set :ruby_version, '2.2.4'
set :bundle_cmd, "chruby-exec #{ruby_version} -- bundle"

default_run_options[:shell] = '/bin/bash'

before 'deploy:create_symlink', 'deploy:precompile_assets'

namespace :deploy do
  desc 'Precompile assets'
  task :precompile_assets do
    run "cd #{release_path} && RACK_ENV=production #{bundle_cmd} exec rake assets:precompile"
  end

  %w(restart start stop).each do |cmd|
    desc "#{cmd.capitalize} the application."
    task cmd do
      run "sudo /usr/sbin/service spaceholder-cc-puma #{cmd}"
    end
  end
end
