class SpaceHolder < Sinatra::Base
  set :server, :puma
  set :views, "#{settings.root}/app/views"

  get '/' do
    erb :index
  end

  get %r{^/(\d+)(x\d+)?$} do |width, height|
    
    if width <= 5000 and height <= 5000
      
      content_type :jpg

      dimensions = height ? "#{width}#{height}" : "#{width}x#{width}"
  
      Image.new(dimensions).manipulate.to_blob
      
    else
     erb :index
    end
    
  end

  not_found do
    erb :'404'
  end
end

Dir.glob('./app/**/*.rb', &method(:require))
