# == Schema Information
#
# Table name: donations
#
#  id             :bigint           not null, primary key
#  value          :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  integration_id :bigint           not null
#  non_profit_id  :bigint           not null
#  user_id        :bigint
#
class Donation < ApplicationRecord
  belongs_to :non_profit
  belongs_to :integration
  belongs_to :user

  has_one :donation_batch
  has_many :donation_blockchain_transactions

  scope :created_between, lambda { |start_date, end_date|
                            where('created_at >= ? AND created_at <= ?', start_date, end_date)
                          }

  def donation_blockchain_transaction
    donation_blockchain_transactions.last
  end

  def create_donation_blockchain_transaction(transaction_hash:, chain:)
    donation_blockchain_transactions.create(transaction_hash:, chain:)
  end

  def impact
    "#{impact_value} #{non_profit.impact_description}"
  end

  def impact_value
    (value / non_profit.impact_for.usd_cents_to_one_impact_unit).to_i
  rescue StandardError
    0
  end
end
