describe Spaceholder::App do
  let(:homepage_content) { 'White space? Try real space.' }
  let(:error_page_content) { '“Houston, we’ve had <a href="https://apollo13.spacelog.org/02:07:55:35/#log-line-201335">a problem</a>.”' }

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

  context 'when POST / with invalid params' do
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
  end

  context 'when POST / with valid params' do
    it 'redirects' do
      post '/', width: 200, height: 100

      expect(last_response.redirect?).to be(true)

      follow_redirect!

      expect(last_request.path).to eq('/200x100')
    end
  end

  context 'when GET /0' do
    it 'redirects' do
      get '/0'

      expect(last_response.redirect?).to be(true)

      follow_redirect!

      expect(last_request.path).to eq('/')
    end
  end

  context 'when GET /200' do
    it 'returns a JPG' do
      get '/200'

      expect(last_response.content_type).to eq('image/jpeg')
    end
  end

  context 'when GET /100x0' do
    it 'redirects' do
      get '/100x0'

      expect(last_response.redirect?).to be(true)

      follow_redirect!

      expect(last_request.path).to eq('/')
    end
  end

  context 'when GET /200x100' do
    it 'returns a JPG' do
      get '/200x100'

      expect(last_response.content_type).to eq('image/jpeg')
    end
  end

  context 'when GET /foo' do
    it 'renders the 404 view' do
      get '/foo'

      expect(last_response.status).to eq(404)
      expect(last_response.body).to include(error_page_content)
    end
  end
end
