module IntegrationRequestsHelpers
  shared_context 'when making an integration request' do
    let(:headers) do
      { Authorization: "Bearer #{token}" }
    end

    let(:integration) { create(:integration) }
    let(:token) { 'valid_token' }

    before do
      integration.api_keys.create!(token:)
    end
  end
end
