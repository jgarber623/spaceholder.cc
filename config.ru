lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

env = (ENV['RACK_ENV'] || 'development').to_sym

require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, env)

if env == :production
  use Rack::SslEnforcer, redirect_html: false
  use Rack::Deflater
end

use Rack::Protection::ContentSecurityPolicy, default_src: "'self'", script_src: "'self' 'unsafe-inline'", style_src: "'self' 'unsafe-inline'", frame_ancestors: "'none'"

require 'spaceholder'

run Spaceholder::App
