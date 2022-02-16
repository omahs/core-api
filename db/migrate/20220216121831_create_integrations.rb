class CreateIntegrations < ActiveRecord::Migration[7.0]
  def change
    create_table :integrations do |t|
      t.string :name
      t.string :wallet_address
      t.string :url

      t.timestamps
    end
  end
end
