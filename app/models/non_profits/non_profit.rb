# == Schema Information
#
# Table name: non_profits
#
#  id                 :bigint           not null, primary key
#  impact_description :text
#  name               :string
#  status             :integer          default("inactive")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  cause_id           :bigint
#
class NonProfit < ApplicationRecord
  extend Mobility
  attr_accessor :wallet_address


  translates :impact_description, :description, type: :string

  has_one_attached :logo
  has_one_attached :main_image
  has_one_attached :background_image
  has_one_attached :cover_image
  has_many :non_profit_impacts
  has_many :wallets, as: :owner

  has_many :non_profit_pools
  has_many :pools, through: :non_profit_pools

  validates :name, :impact_description, :status, :wallet_address, presence: true

  belongs_to :cause

  enum status: {
    inactive: 0,
    active: 1
  }

  def impact_for(date: Time.zone.now)
    non_profit_impacts.find_by('start_date <= ? AND end_date >= ?', date, date)
  end

  def impact_by_ticket(date: Time.zone.now)
    impact_for(date:)&.impact_by_ticket
  end

  def wallet_address
    self.wallets.where(status: :active).last ? self.wallets.where(status: :active).last.address : self.wallets.last&.active? ? self.wallets.last.address : nil
  end

  def wallet_address=(value)
    byebug
    self.wallets.where(address: value).first_or_initialize(status: :active)
    
  end
end
