module Spaceholder
  class App < Sinatra::Base
    DIMENSIONS_REGEXP = /([1-4]?\d{1,3}|5000)/.freeze

    configure do
      use Rack::Protection, except: [:remote_token, :session_hijacking, :xss_header]
      use Rack::Protection::ContentSecurityPolicy, default_src: "'self'", script_src: "'self' 'unsafe-inline'", style_src: "'self' 'unsafe-inline'", frame_ancestors: "'none'"
      use Rack::Protection::StrictTransport, max_age: 31536000, include_subdomains: true, preload: true

      set :root, File.dirname(File.expand_path('..', __dir__))
      set :server, :puma

      set :assets_css_compressor, :sass
      set :assets_paths, %w[assets/fonts assets/images assets/stylesheets]
      set :assets_precompile, %w[application.css *.png *.svg *.woff *.woff2]
    end

    configure :production do
      use Rack::SslEnforcer, redirect_html: false
      use Rack::HostRedirect, %w[spaceholder-cc.herokuapp.com www.spaceholder.cc] => 'spaceholder.cc'
      use Rack::Deflater
    end

    register Sinatra::AssetPipeline

    get '/' do
      cache_control :public

      erb :index
    end

    post '/' do
      return erb :index unless params.key?('width') && params.key?('height')

      redirect "/#{params[:width]}x#{params[:height]}"
    end

    get %r{/#{DIMENSIONS_REGEXP}(?:x#{DIMENSIONS_REGEXP})?} do |width, height|
      return redirect '/' unless width.to_i.positive?
      return redirect '/' if height && height.to_i <= 0

      content_type :jpg

      cache_control :public, max_age: 3600

      headers 'X-Content-Type-Options' => 'nosniff'

      begin
        tempfile = Image.new(width, height).manipulate
        tempfile.read
      ensure
        tempfile.close!
      end
    end

    not_found do
      cache_control :public

      erb :'404'
    end
  end
end
