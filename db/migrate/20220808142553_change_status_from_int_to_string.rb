class ChangeStatusFromIntToString < ActiveRecord::Migration[7.0]
  def change
    change_column :integrations, :status, :string, default: "active"
  end
end
