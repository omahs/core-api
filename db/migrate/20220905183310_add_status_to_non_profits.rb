class AddStatusToNonProfits < ActiveRecord::Migration[7.0]
  def change
    add_column :non_profits, :status, :integer, default: 1
  end
end
