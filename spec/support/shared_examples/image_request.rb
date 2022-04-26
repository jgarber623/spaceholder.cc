# frozen_string_literal: true

RSpec.shared_examples 'an image request' do
  it { is_expected.to be_ok }
  its(:content_type) { is_expected.to eq('image/jpeg') }
end
