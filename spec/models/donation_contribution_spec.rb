# == Schema Information
#
# Table name: donation_contributions
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  contribution_id :bigint           not null
#
require 'rails_helper'

RSpec.describe DonationContribution, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
