class Donation < ApplicationRecord
  belongs_to :non_profit
  belongs_to :integration
  belongs_to :user

  has_one :donation_blockchain_transaction
end
