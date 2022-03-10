class User < ApplicationRecord
  validates :email, uniqueness: { case_sensitive: true }, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation { email.downcase! }
  after_create :set_user_donation_stats

  has_many :donations

  has_one :user_donation_stats

  delegate :last_donation_at, to: :user_donation_stats
  delegate :can_donate?, to: :user_donation_stats

  def impact
    donation_balances = Graphql::RibonApi::Client.query(Graphql::Queries::FetchDonationBalances::Query)

    user_donations = donation_balances.original_hash['data']['donationBalances'].select do |x|
      x['user'] == hashed_email
    end

    result = {}

    user_donations.each do |donation|
      result[donation['nonProfit']] = donation['totalDonated']
    end

    result
  end

  def hashed_email
    "0x#{Digest::Keccak.new(256).hexdigest(email)}"
  end

  private

  def set_user_donation_stats
    create_user_donation_stats unless user_donation_stats
  end
end
