require 'rubygems'
require 'bundler'

Bundler.require

class SpaceHolder < Sinatra::Base
  set :server, :puma
  set :views, "#{settings.root}/app/views"

  set :assets_css_compressor, :sass
  set :assets_precompile, %w(application.css *.png *.svg *.woff *.woff2)
  set :assets_prefix, %w(app/assets)

  register Sinatra::AssetPipeline

  get '/' do
    erb :index
  end

  post '/' do
    if params[:width].length > 0 && params[:height].length > 0
      redirect %{/#{params[:width]}x#{params[:height]}}
    else
      erb :index
    end
  end

  get %r{^/((?:[1-4]?\d{1,3}|5000))(x(?:[1-4]?\d{1,3}|5000))?$} do |width, height|
    content_type :jpg

    dimensions = height ? "#{width}#{height}" : "#{width}x#{width}"

    Image.new(dimensions).manipulate.to_blob
  end

  not_found do
    erb :'404'
  end
end

Dir.glob('./app/**/*.rb', &method(:require))
