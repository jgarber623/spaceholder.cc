class SpaceHolder < Sinatra::Base
  set :server, :puma
  set :views, "#{settings.root}/app/views"

  get '/' do
    erb :index
  end

  get %r{^/(\d+)(x\d+)?$} do |width, height|
    content_type :jpg

    dimensions = height ? "#{width}#{height}" : "#{width}x#{width}"

    Image.new(dimensions).render_to_blob
  end

  not_found do
    erb :'404'
  end
end

Dir.glob('./app/**/*.rb', &method(:require))
