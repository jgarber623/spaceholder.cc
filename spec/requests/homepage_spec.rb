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
    context 'when invalid params' do
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

    context 'when valid params' do
      before do
        post '/', width: 200, height: 100
      end

      it 'redirects' do
        expect(last_response.redirect?).to be(true)
      end

      it 'redirects' do
        follow_redirect!

        expect(last_request.path).to eq('/200x100')
      end
    end
  end
end
