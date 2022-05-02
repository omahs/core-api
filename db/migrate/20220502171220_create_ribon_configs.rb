class CreateRibonConfigs < ActiveRecord::Migration[7.0]
  def change
    create_table :ribon_configs do |t|
      t.integer :default_ticket_value

      t.timestamps
    end
  end
end
