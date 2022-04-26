# frozen_string_literal: true

RSpec.shared_examples 'an image request' do
  it { is_expected.to be_ok }
  it { expect(response.content_type).to eq('image/jpeg') }
end
