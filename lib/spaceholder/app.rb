module Spaceholder
  class App < Sinatra::Base
    SINATRA_PARAM_OPTIONS = { raise: true, required: true, within: (1..5000) }.freeze

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

    helpers Sinatra::Param

    get '/' do
      cache_control :public

      erb :index
    end

    post '/' do
      param :width, :integer, SINATRA_PARAM_OPTIONS
      param :height, :integer, SINATRA_PARAM_OPTIONS

      redirect "/#{params[:width]}x#{params[:height]}"
    rescue InvalidParameterError
      return erb :index
    end

    get %r{/(?<width>\d{1,4})(?:x(?<height>\d{1,4}))?} do
      param :width, :integer, SINATRA_PARAM_OPTIONS
      param :height, :integer, SINATRA_PARAM_OPTIONS.merge(required: false)

      begin
        content_type :jpg

        cache_control :public, max_age: 3600

        headers 'X-Content-Type-Options' => 'nosniff'

        tempfile = Image.new(params[:width], params[:height]).manipulate
        tempfile.read
      ensure
        tempfile.close!
      end
    rescue InvalidParameterError
      redirect '/'
    end

    not_found do
      cache_control :public

      erb :'404'
    end
  end
end
