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
  belongs_to :receiver, polymorphic: true
  belongs_to :person_payment

  delegate :liquid_value_cents, to: :person_payment
  delegate :crypto_value_cents, to: :person_payment
end
