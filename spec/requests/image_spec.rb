describe Spaceholder::App do
  context 'when GET /0' do
    before do
      get '/0'
    end

    it 'redirects' do
      expect(last_response.redirect?).to be(true)
    end

    it 'redirects' do
      follow_redirect!

      expect(last_request.path).to eq('/')
    end
  end

  context 'when GET /100x0' do
    before do
      get '/100x0'
    end

    it 'redirects' do
      expect(last_response.redirect?).to be(true)
    end

    it 'redirects' do
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
end
