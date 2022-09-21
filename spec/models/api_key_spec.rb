# == Schema Information
#
# Table name: api_keys
#
#  id           :bigint           not null, primary key
#  bearer_type  :string           not null
#  token_digest :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  bearer_id    :bigint           not null
#
require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  describe '.authenticate_by_token!' do
    let!(:api_key) { described_class.create!(bearer: integration, token:) }
    let(:integration) { create(:integration) }
    let(:token) { 'valid_token' }

    it 'finds the api key based on the token' do
      expect(described_class.authenticate_by_token!(token)).to eq api_key
    end
  end
end
