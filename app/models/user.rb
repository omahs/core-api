class User < ApplicationRecord
  validates :email, uniqueness: { case_sensitive: true }, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation { email.downcase! }
  has_many :donations
  has_one :user_donation_stats

  after_create :set_user_donation_stats

  delegate :last_donation_at, to: :user_donation_stats

  private

  def set_user_donation_stats
    create_user_donation_stats unless user_donation_stats
  end
end
