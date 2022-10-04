class CreateIntegrationWebhooks < ActiveRecord::Migration[7.0]
  def change
    create_table :integration_webhooks do |t|
      t.references :integration, null: false, foreign_key: true
      t.string :url

      t.timestamps
    end
  end
end
