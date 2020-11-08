describe Spaceholder::App do
  context 'when GET /foo' do
    it 'renders the not_found view' do
      error_page_content = '“Houston, we’ve had <a href="https://apollo13.spacelog.org/02:07:55:35/#log-line-201335">a problem</a>.”'

      get '/foo'

      expect(last_response.status).to eq(404)
      expect(last_response.body).to include(error_page_content)
    end
  end
end
