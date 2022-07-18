class CreateSources < ActiveRecord::Migration[7.0]
  def change
    create_table :sources do |t|
      t.references :user, index: true
      t.references :integration, index: true

      t.timestamps
    end
  end
end
