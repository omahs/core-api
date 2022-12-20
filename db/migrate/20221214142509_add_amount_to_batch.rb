class AddAmountToBatch < ActiveRecord::Migration[7.0]
  def change
    add_column :batches, :amount, :decimal
  end
end
