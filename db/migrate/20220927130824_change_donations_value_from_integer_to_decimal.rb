class ChangeDonationsValueFromIntegerToDecimal < ActiveRecord::Migration[7.0]
  def change
    change_column :donations, :value, :decimal
  end
end
