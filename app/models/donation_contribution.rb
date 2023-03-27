# == Schema Information
#
# Table name: donation_contributions
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  contribution_id :bigint           not null
#
class DonationContribution < ApplicationRecord
  belongs_to :contribution

  delegate :value, to: :donation
end
