# == Schema Information
#
# Table name: batches
#
#  id         :bigint           not null, primary key
#  cid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Batch, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
