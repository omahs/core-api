class CreateOfferGateways < ActiveRecord::Migration[7.0]
  def change
    create_table :offer_gateways do |t|
      t.references :offer, null: false, foreign_key: true
      t.string :external_id
      t.integer :gateway

      t.timestamps
    end
  end
end
