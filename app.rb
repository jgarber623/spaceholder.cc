class SpaceHolder < Sinatra::Base
  set :server, :puma
  set :views, "#{settings.root}/app/views"

  get '/' do
    erb :index
  end

  get %r{^/(\d+x\d+)$} do |dimensions|
    content_type :jpg
    Image.new(dimensions).manipulate.to_blob
  end

  not_found do
    erb :'404'
  end
end

Dir.glob('./app/**/*.rb', &method(:require))
