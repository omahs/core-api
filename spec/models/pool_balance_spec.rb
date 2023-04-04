# == Schema Information
#
# Table name: pool_balances
#
#  id         :bigint           not null, primary key
#  balance    :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pool_id    :bigint           not null
#
require 'rails_helper'

RSpec.describe PoolBalance, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
