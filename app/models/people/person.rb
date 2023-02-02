# == Schema Information
#
# Table name: people
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Person < ApplicationRecord
  include UuidHelper

  has_one :guest, dependent: :destroy
  has_one :customer, dependent: :destroy
  has_many :person_payments, dependent: :nullify

  delegate :email, to: :customer, allow_nil: true
  delegate :wallet_address, to: :customer, allow_nil: true

  def guest?
    guest.present?
  end

  def customer?
    customer.present?
  end

  def guest_or_customer?
    guest? || customer?
  end

  def guest_or_customer
    guest? ? guest : customer
  end
end
