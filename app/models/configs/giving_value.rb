# == Schema Information
#
# Table name: giving_values
#
#  id         :bigint           not null, primary key
#  currency   :integer          default("usd")
#  value      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class GivingValue < ApplicationRecord
  validates :value, :currency, presence: true

  enum currency: {
    usd: 0,
    brl: 1
  }

  def currency_symbol
    return '$' if usd?
    return 'R$' if brl?

    ''
  end
end
