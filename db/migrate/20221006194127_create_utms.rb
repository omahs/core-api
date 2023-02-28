class CreateUtms < ActiveRecord::Migration[7.0]
  def change
    create_table :utms do |t|
      t.string :source
      t.string :medium
      t.string :campaign
      t.references :trackable, polymorphic: true

      t.timestamps
    end
  end
end
