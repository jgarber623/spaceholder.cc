# frozen_string_literal: true

RSpec.shared_examples 'a homepage redirect request' do
  it { is_expected.to be_redirect }

  it 'redirects' do
    response

    follow_redirect!

    expect(last_request.path).to eq('/')
  end
end
