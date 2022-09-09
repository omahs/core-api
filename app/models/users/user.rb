# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates :email, uniqueness: { case_sensitive: true }, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation { email.downcase! }
  after_create :set_user_donation_stats

  has_many :donations
  has_many :customers

  has_one :user_donation_stats

  delegate :last_donation_at, to: :user_donation_stats
  delegate :can_donate?, to: :user_donation_stats

  def impact
    UserServices::UserImpact.new(user: self).impact
  end

  private

  def set_user_donation_stats
    create_user_donation_stats unless user_donation_stats
  end
end
