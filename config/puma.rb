# frozen_string_literal: true

port ENV.fetch('PORT', 8080)

environment ENV.fetch('RACK_ENV', 'development')

pidfile ENV.fetch('PIDFILE', 'tmp/pids/server.pid')

max_threads_count = ENV.fetch('MAX_THREADS', 5)
min_threads_count = ENV.fetch('MIN_THREADS', max_threads_count)
threads min_threads_count, max_threads_count

workers ENV.fetch('WEB_CONCURRENCY', 4)

preload_app!
