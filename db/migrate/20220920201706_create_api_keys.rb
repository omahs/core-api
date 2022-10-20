class CreateApiKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :api_keys do |t|
      t.references :bearer, polymorphic: true, null: false
      t.string :token_digest

      t.timestamps
    end
  end
end
