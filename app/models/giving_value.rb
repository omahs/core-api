class GivingValue < ApplicationRecord
  enum currency: {
    usd: 0,
    brl: 1
  }
end
