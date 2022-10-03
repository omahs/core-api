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
  pending "add some examples to (or delete) #{__FILE__}"
end
