# == Schema Information
#
# Table name: blockchain_transactions
#
#  id               :bigint           not null, primary key
#  owner_type       :string           not null
#  status           :integer          default("processing")
#  transaction_hash :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  chain_id         :bigint           not null
#  owner_id         :bigint           not null
#
require 'rails_helper'

RSpec.describe BlockchainTransaction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
