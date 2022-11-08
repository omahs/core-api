class AddNameToPool < ActiveRecord::Migration[7.0]
  def change
    add_column :pools, :name, :string
  end
end
