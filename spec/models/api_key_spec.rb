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
  pending "add some examples to (or delete) #{__FILE__}"
end
