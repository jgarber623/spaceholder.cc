lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

env = ENV['RACK_ENV'].to_sym

require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, env)

use Rack::Deflater if env == :production

require 'spaceholder'

run Spaceholder::App
