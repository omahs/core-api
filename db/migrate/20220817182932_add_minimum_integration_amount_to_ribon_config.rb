class AddMinimumIntegrationAmountToRibonConfig < ActiveRecord::Migration[7.0]
  def change
    add_column :ribon_configs, :minimum_integration_amount, :decimal
  end
end
