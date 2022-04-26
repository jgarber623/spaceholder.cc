# frozen_string_literal: true

RSpec.shared_context 'Roda app', roda: :app do
  subject(:response) { last_response }
end
