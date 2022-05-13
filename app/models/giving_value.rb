class GivingValue < ApplicationRecord
  enum currency: {
    usd: 0,
    brl: 1
  }

  def currency_symbol
    return "$" if usd?
    return "R$" if brl?

    ""
  end
end
