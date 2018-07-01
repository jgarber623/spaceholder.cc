#!/usr/bin/env puma

workers     Integer(ENV['WEB_CONCURRENCY'] || 2)
threads     5, 5

preload_app!

rackup      'config.ru'
environment ENV['RACK_ENV'] || 'development'
port        ENV['PORT'] || 9292
