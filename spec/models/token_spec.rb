# == Schema Information
#
# Table name: tokens
#
#  id         :bigint           not null, primary key
#  address    :string
#  decimals   :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chain_id   :bigint
#
# Indexes
#
#  index_tokens_on_chain_id  (chain_id)
#
require 'rails_helper'

RSpec.describe Token, type: :model do
  describe '.validations' do
    subject { build(:token) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:decimals) }
    it { is_expected.to belong_to(:chain) }
  end
end
