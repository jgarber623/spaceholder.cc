require 'rubygems'
require 'bundler'

Bundler.require

class SpaceHolder < Sinatra::Base
  set :server, :puma
  set :protection, except: [:frame_options, :xss_header]

  set :assets_css_compressor, :sass
  set :assets_precompile, %w[application.css *.png *.svg *.woff *.woff2]

  register Sinatra::AssetPipeline

  get '/' do
    erb :index
  end

  post '/' do
    if params.key?(:width) && params.key?(:height)
      redirect "/#{params[:width]}x#{params[:height]}"
    else
      erb :index
    end
  end

  get %r{^/([1-4]?\d{1,3}|5000)(?:x([1-4]?\d{1,3}|5000))?$} do |width, height|
    content_type :jpg

    Image.new(width, height).manipulate.to_blob
  end

  not_found do
    erb :'404'
  end
end

Dir.glob(File.join(SpaceHolder.settings.root, 'lib', '*.rb'), &method(:require))
