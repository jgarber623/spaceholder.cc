describe Spaceholder::App do
  let(:error_page_content) { '“Houston, we’ve had <a href="https://apollo13.spacelog.org/02:07:55:35/#log-line-201335">a problem</a>.”' }

  context 'when GET /foo' do
    before do
      get '/foo'
    end

    it 'returns a not found HTTP status code' do
      expect(last_response.status).to eq(404)
    end

    it 'renders the 404 view' do
      expect(last_response.body).to include(error_page_content)
    end
  end
end
