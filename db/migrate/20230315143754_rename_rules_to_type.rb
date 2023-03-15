class RenameRulesToType < ActiveRecord::Migration[7.0]
  def change
    rename_column :tasks, :rules, :type
  end
end
