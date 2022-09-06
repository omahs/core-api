class AddStatusToNonProfits < ActiveRecord::Migration[7.0]
  def change
    add_column :non_profits, :status, :string, default: "active"
  end
end
