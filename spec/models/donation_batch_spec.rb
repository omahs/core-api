# == Schema Information
#
# Table name: donation_batches
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  batch_id    :bigint           not null
#  donation_id :bigint           not null
#
require 'rails_helper'

RSpec.describe DonationBatch, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
