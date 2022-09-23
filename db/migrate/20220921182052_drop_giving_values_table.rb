class DropGivingValuesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :giving_values
  end
end
