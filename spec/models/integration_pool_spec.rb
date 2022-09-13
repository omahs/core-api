# == Schema Information
#
# Table name: integration_pools
#
#  id             :bigint           not null, primary key
#  integration_id :bigint           not null
#  pool_id        :bigint           not null
#
require 'rails_helper'

RSpec.describe IntegrationPool, type: :model do
  describe '.validations' do
    subject { build(:integration_pool) }

    it { is_expected.to belong_to(:integration) }
    it { is_expected.to belong_to(:pool) }
  end
end
