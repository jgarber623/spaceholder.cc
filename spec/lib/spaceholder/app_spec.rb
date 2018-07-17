describe Spaceholder::App do
  let(:homepage_content) { 'White space? Try real space.' }

  context 'when GET /' do
    before do
      get '/'
    end

    it 'returns a successful HTTP status code' do
      expect(last_response.status).to eq(200)
    end

    it 'renders the index view' do
      expect(last_response.body).to include(homepage_content)
    end
  end

  context 'when POST /' do
    it 'renders the index view when missing params' do
      post '/'

      expect(last_response.body).to include(homepage_content)
    end

    it 'renders the index view when missing height param' do
      post '/', width: 100

      expect(last_response.body).to include(homepage_content)
    end

    it 'renders the index view when missing width param' do
      post '/', height: 100

      expect(last_response.body).to include(homepage_content)
    end

    it 'redirects' do
      post '/', width: 100, height: 100

      expect(last_response.redirect?).to be(true)
    end
  end

  context 'when GET /foo' do
    before do
      get '/foo'
    end

    it 'returns a not found HTTP status code' do
      expect(last_response.status).to eq(404)
    end

    it 'renders the 404 view' do
      expect(last_response.body).to include('It’s not as bad as an exploded oxygen tank')
    end
  end

  context 'when GET /0' do
    it 'redirects' do
      get '/0'

      expect(last_response.redirect?).to be(true)
    end
  end

  context 'when GET /100x0' do
    it 'redirects' do
      get '/100x0'

      expect(last_response.redirect?).to be(true)
    end
  end

  context 'when GET /200x100' do
    it 'returns a JPG' do
      get '/200x100'

      expect(last_response.content_type).to eq('image/jpeg')
    end
  end
end
