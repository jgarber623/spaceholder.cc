# config valid only for current version of Capistrano
lock '3.10.2'

set :application, 'spaceholder.cc'
set :repo_url, 'git@github.com:jgarber623/spaceholder.cc.git'
set :chruby_ruby, 'ruby-2.5.1'

append :linked_dirs, 'tmp/pids', 'tmp/sockets'

before 'deploy:publishing', 'assets:precompile'
after 'deploy:finished', 'puma:restart'
