module Spaceholder
  class App < Sinatra::Base
    DIMENSIONS_REGEXP = /([1-4]?\d{1,3}|5000)/

    set :root, File.dirname(File.expand_path('..', __dir__))

    set :protection, except: [:xss_header]
    set :server, :puma

    set :assets_css_compressor, :sass
    set :assets_paths, %w[assets/fonts assets/images assets/stylesheets]
    set :assets_precompile, %w[application.css *.png *.svg *.woff *.woff2]

    register Sinatra::AssetPipeline

    get '/' do
      cache_control :public

      erb :index
    end

    post '/' do
      return erb :index unless params.key?('width') && params.key?('height')

      redirect "/#{params[:width]}x#{params[:height]}"
    end

    get %r{/#{DIMENSIONS_REGEXP}} do |width|
      return redirect '/' unless width.to_i.positive?

      render_image(width, width)
    end

    get %r{/#{DIMENSIONS_REGEXP}x#{DIMENSIONS_REGEXP}} do |width, height|
      return redirect '/' unless width.to_i.positive? && height.to_i.positive?

      render_image(width, height)
    end

    not_found do
      cache_control :public

      erb :'404'
    end

    private

    def render_image(width, height)
      content_type :jpg

      cache_control :public, max_age: 3600

      headers 'X-Content-Type-Options' => 'nosniff'

      tempfile = Image.new(width, height).manipulate

      begin
        tempfile.read
      ensure
        tempfile.close!
      end
    end
  end
end
