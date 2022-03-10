class User < ApplicationRecord
  validates :email, uniqueness: { case_sensitive: true }, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation { email.downcase! }
  has_many :donations

  def impact
    donation_balances = Graphql::RibonApi::Client.query(Graphql::Queries::FetchDonationBalances::Query)

    user_donations = donation_balances.original_hash["data"]["donationBalances"].select { |x| x["user"] == hashed_email }

    result = {}

    user_donations.each do |donation|
      result[donation["nonProfit"]] = donation["totalDonated"]
    end

    result
  end

  def hashed_email
    '0x' + Digest::Keccak.new(256).hexdigest(email)
  end
end
