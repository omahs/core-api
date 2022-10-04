# == Schema Information
#
# Table name: badges
#
#  id             :bigint           not null, primary key
#  category       :integer
#  description    :text
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  merit_badge_id :integer
#
class Badge < ApplicationRecord
  has_one_attached :image

  enum category: { onboarding: 0, donation: 1 }

  delegate :users, to: :merit_badge

  validates :merit_badge_id, :description, :category, :name, presence: true

  def merit_badge
    Merit::Badge.find(merit_badge_id)
  end
end
