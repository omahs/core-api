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
class DonationBatch < ApplicationRecord
  belongs_to :donation
  belongs_to :batch
end
