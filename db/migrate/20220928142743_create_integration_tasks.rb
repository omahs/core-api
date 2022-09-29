class CreateIntegrationTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :integration_tasks do |t|
      t.string :description
      t.string :link
      t.string :link_address
      t.references :integration, null: false, foreign_key: true

      t.timestamps
    end
  end
end
