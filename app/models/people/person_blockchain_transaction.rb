class PersonBlockchainTransaction < ApplicationRecord
  belongs_to :person_payment

  enum treasure_entry_status: {
    processing: 0,
    success: 1,
    failed: 2
  }
end
