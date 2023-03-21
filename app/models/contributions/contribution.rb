# == Schema Information
#
# Table name: contributions
#
#  id                :bigint           not null, primary key
#  receiver_type     :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  person_payment_id :bigint           not null
#  receiver_id       :bigint           not null
#
class Contribution < ApplicationRecord
  # TODO: remove receiver - already exists in person_payment
  belongs_to :receiver, polymorphic: true
  belongs_to :person_payment
  has_one :contribution_balance
  has_many :contribution_fees

  delegate :liquid_value_cents, to: :person_payment
  delegate :crypto_value_cents, to: :person_payment

  def set_contribution_balance
    fee_percentage = RibonConfig.contribution_fee_percentage
    create_contribution_balance!(
      total_fees_increased_cents: 0,
      tickets_balance_cents: liquid_value_cents * (100 - fee_percentage) / 100,
      fees_balance_cents: liquid_value_cents * (fee_percentage / 100)
    )
  rescue StandardError => e
    Reporter.log(error: e)
  end
end
