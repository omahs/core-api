# == Schema Information
#
# Table name: non_profit_pools
#
#  id            :bigint           not null, primary key
#  non_profit_id :bigint           not null
#  pool_id       :bigint           not null
#
require 'rails_helper'

RSpec.describe NonProfitPool, type: :model do
  describe '.validations' do
    subject { build(:non_profit_pool) }

    it { is_expected.to belong_to(:non_profit) }
    it { is_expected.to belong_to(:pool) }
  end
end
