lib = File.expand_path('../lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'bundler/setup'

Bundler.require(:default, (ENV['RACK_ENV'] || 'development').to_sym)

require 'spaceholder'
