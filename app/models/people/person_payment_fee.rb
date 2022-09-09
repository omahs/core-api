# == Schema Information
#
# Table name: person_payment_fees
#
#  id                :bigint           not null, primary key
#  card_fee_cents    :integer
#  crypto_fee_cents  :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  person_payment_id :bigint           not null
#
# Indexes
#
#  index_person_payment_fees_on_person_payment_id  (person_payment_id)
#
# Foreign Keys
#
#  fk_rails_...  (person_payment_id => person_payments.id)
#
class PersonPaymentFee < ApplicationRecord
  belongs_to :person_payment

  def service_fee_cents
    card_fee_cents + crypto_fee_cents
  end

  def card_fee
    card_fee_cents / 100.0
  end

  def crypto_fee
    crypto_fee_cents / 100.0
  end

  def service_fee
    service_fee_cents / 100.0
  end
end
