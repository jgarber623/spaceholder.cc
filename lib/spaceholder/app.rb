module Spaceholder
  class App < Sinatra::Base
    DIMENSIONS_REGEXP = /([1-4]?\d{1,3}|5000)/

    set :root, File.dirname(File.expand_path('../..', __FILE__))

    set :server, :puma
    set :protection, except: [:frame_options, :xss_header]

    set :assets_css_compressor, :sass
    set :assets_precompile, %w[application.css *.png *.svg *.woff *.woff2]

    register Sinatra::AssetPipeline

    get '/' do
      erb :index
    end

    post '/' do
      return erb :index unless params.key?('width') && params.key?('height')

      redirect "/#{params[:width]}x#{params[:height]}"
    end

    get %r{^/#{DIMENSIONS_REGEXP}$} do |width|
      return redirect '/' unless width.to_i.positive?

      render_image(width, width)
    end

    get %r{^/#{DIMENSIONS_REGEXP}x#{DIMENSIONS_REGEXP}$} do |width, height|
      return redirect '/' unless width.to_i.positive? && height.to_i.positive?

      render_image(width, height)
    end

    not_found do
      erb :'404'
    end

    private

    def render_image(width, height)
      content_type :jpg

      Image.new(width, height).manipulate.to_blob
    end
  end
end
