class RemoveMininumIntegrationAmountFromRibonConfigs < ActiveRecord::Migration[7.0]
  def change
    remove_column :ribon_configs, :minimum_integration_amount
  end
end
