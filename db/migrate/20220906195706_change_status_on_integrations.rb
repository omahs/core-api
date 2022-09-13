class ChangeStatusOnIntegrations < ActiveRecord::Migration[7.0]
  def change
    add_column :integrations, :new_status, :integer

    execute "UPDATE integrations SET new_status = 0 WHERE status = 'inactive'"
    execute "UPDATE integrations SET new_status = 1 WHERE status = 'active'"

    change_column_default :integrations, :new_status, 0

    rename_column :integrations, :status, :old_status
    rename_column :integrations, :new_status, :status

    remove_column :integrations, :old_status
  end
end
