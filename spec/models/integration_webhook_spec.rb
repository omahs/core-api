# == Schema Information
#
# Table name: integration_webhooks
#
#  id             :bigint           not null, primary key
#  url            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  integration_id :bigint           not null
#
require 'rails_helper'

RSpec.describe IntegrationWebhook, type: :model do
  describe '.validations' do
    subject { build(:integration_webhook) }

    it { is_expected.to validate_presence_of(:url) }
  end

  describe '.associations' do
    subject { build(:integration_webhook) }

    it { is_expected.to belong_to(:integration) }
  end
end
