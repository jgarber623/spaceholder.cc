# frozen_string_literal: true

RSpec.shared_examples 'a homepage request' do
  it { expect(response).to be_ok }
  it { expect(response.body).to include('White space? Try real space.') }
end
