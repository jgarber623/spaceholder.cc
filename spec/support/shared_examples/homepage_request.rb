# frozen_string_literal: true

RSpec.shared_examples 'a homepage request' do
  it { is_expected.to be_ok }
  its(:body) { is_expected.to include('White space? Try real space.') }
end
