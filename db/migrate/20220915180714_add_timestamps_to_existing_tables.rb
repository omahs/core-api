class AddTimestampsToExistingTables < ActiveRecord::Migration[7.0]
  def change
    change_table(:causes)            { |t| t.timestamps }
    change_table(:integration_pools) { |t| t.timestamps }
    change_table(:non_profit_pools)  { |t| t.timestamps }
  end
end
