describe Spaceholder::App do
  context 'when requesting the homepage' do
    before do
      get '/'
    end

    it 'returns an HTTP status code' do
      expect(last_response.status).to eq(200)
    end

    it 'renders the index view' do
      expect(last_response.body).to include('White space? Try real space.')
    end
  end
end
