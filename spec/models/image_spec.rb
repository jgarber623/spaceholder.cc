# frozen_string_literal: true

RSpec.describe Image do
  subject(:image) { described_class.new(200, 100) }

  describe '#process' do
    it { expect(image.process).to be_a(Tempfile) }
  end
end
