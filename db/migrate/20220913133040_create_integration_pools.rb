class CreateIntegrationPools < ActiveRecord::Migration[7.0]
  def change
    create_table :integration_pools do |t|
      t.references :integration, null: false, foreign_key: true
      t.references :pool, null: false, foreign_key: true
    end
  end
end
