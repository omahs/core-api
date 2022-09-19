# == Schema Information
#
# Table name: wallets
#
#  id         :bigint           not null, primary key
#  address    :string
#  owner_type :string           not null
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
require 'rails_helper'

RSpec.describe Wallet, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
