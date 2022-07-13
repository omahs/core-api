class PersonBlockchainTransaction < ApplicationRecord
  belongs_to :person_payment

  after_create :update_status_from_eth_network

  enum treasure_entry_status: {
    processing: 0,
    success: 1,
    failed: 2
  }

  def update_status_from_eth_network
    PersonPayments::UpdateBlockchainTransactionStatusJob
      .set(wait_until: 5.minutes.from_now)
      .perform_later(self)
  end
end
