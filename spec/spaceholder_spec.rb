# frozen_string_literal: true

RSpec.describe Spaceholder do
  describe 'GET /' do
    it_behaves_like 'a homepage request' do
      let(:response) { get '/' }
    end
  end

  describe 'POST /' do
    context 'when no params' do
      it_behaves_like 'a homepage request' do
        let(:response) { post '/' }
      end
    end

    context 'when missing height param' do
      it_behaves_like 'a homepage request' do
        let(:response) { post '/', width: 100 }
      end
    end

    context 'when missing width param' do
      it_behaves_like 'a homepage request' do
        let(:response) { post '/', height: 100 }
      end
    end

    context 'when valid params' do
      let(:response) { post '/', width: 200, height: 100 }

      it { expect(response).to be_redirect }

      it 'redirects' do
        response

        follow_redirect!

        expect(last_request.path).to eq('/200x100')
      end
    end
  end

  describe 'GET /foo' do
    let(:response) { get '/foo' }

    it { expect(response).to be_not_found }
    it { expect(response.body).to include('“Houston, we’ve had <a href="https://apollo13.spacelog.org/02:07:55:35/#log-line-201335">a problem</a>.”') }
  end

  describe 'GET /0' do
    it_behaves_like 'a homepage redirect request' do
      let(:response) { get '/0' }
    end
  end

  describe 'GET /200' do
    it_behaves_like 'an image request' do
      let(:response) { get '/200' }
    end
  end

  describe 'GET /100x0' do
    it_behaves_like 'a homepage redirect request' do
      let(:response) { get '/100x0' }
    end
  end

  describe 'GET /200x100' do
    it_behaves_like 'an image request' do
      let(:response) { get '/200x100' }
    end
  end
end
