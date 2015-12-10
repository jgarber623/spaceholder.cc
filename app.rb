class SpaceHolder < Sinatra::Base
  set :views, %{#{settings.root}/app/views}

  get '/' do
    erb :index
  end

  get %r{^/(\d+x\d+)$} do |dimensions|
    content_type :jpg
    Image.new(dimensions).manipulate.to_blob
  end
end

Dir.glob('./app/**/*.rb', &method(:require))
