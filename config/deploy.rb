# config valid only for current version of Capistrano
lock '3.10.0'

set :application, 'spaceholder.cc'
set :repo_url, 'git@github.com:jgarber623/spaceholder.cc.git'
set :chruby_ruby, 'ruby-2.4.2'

before 'deploy:publishing', 'assets:precompile'
after 'deploy:finished', 'puma:restart'
