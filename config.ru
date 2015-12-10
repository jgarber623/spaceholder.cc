require 'rubygems'
require 'bundler'

Bundler.require

use Rack::Deflater

require './app'
run SpaceHolder.new
