class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.string :address
      t.integer :status
      t.references :owner, polymorphic: true, null: false, index: true

      t.timestamps
    end
  end
end
