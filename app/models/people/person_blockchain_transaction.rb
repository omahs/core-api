# == Schema Information
#
# Table name: person_blockchain_transactions
#
#  id                    :bigint           not null, primary key
#  transaction_hash      :string
#  treasure_entry_status :integer          default("processing")
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  person_payment_id     :bigint
#
# Indexes
#
#  index_person_blockchain_transactions_on_person_payment_id  (person_payment_id)
#
# Foreign Keys
#
#  fk_rails_...  (person_payment_id => person_payments.id)
#
class PersonBlockchainTransaction < ApplicationRecord
  belongs_to :person_payment

  after_create :update_status_from_eth_chain

  enum treasure_entry_status: {
    processing: 0,
    success: 1,
    failed: 2
  }

  def update_status_from_eth_chain
    # TODO: add listener to contract events to call this method
    PersonPayments::UpdateBlockchainTransactionStatusJob
      .set(wait_until: 5.minutes.from_now)
      .perform_later(self)
  end
end
