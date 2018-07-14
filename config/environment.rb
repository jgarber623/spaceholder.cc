lib = File.expand_path('../lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

env = (ENV['RACK_ENV'] || 'development').to_sym

require 'bundler/setup'

Bundler.require(:default, env)

if env == :production
  use Rack::SslEnforcer, redirect_html: false
  use Rack::HostRedirect, %w[spaceholder-cc.herokuapp.com www.spaceholder.cc] => 'spaceholder.cc'
  use Rack::Deflater
end

use Rack::Protection::ContentSecurityPolicy, default_src: "'self'", script_src: "'self' 'unsafe-inline'", style_src: "'self' 'unsafe-inline'", frame_ancestors: "'none'"
use Rack::Protection::StrictTransport, max_age: 31536000, include_subdomains: true, preload: true

require 'spaceholder'
