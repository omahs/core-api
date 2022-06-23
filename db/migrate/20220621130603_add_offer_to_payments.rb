class AddOfferToPayments < ActiveRecord::Migration[7.0]
  def change
    add_reference :customer_payments, :offer, foreign_key: true
  end
end
