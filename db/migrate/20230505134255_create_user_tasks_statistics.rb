class CreateUserTasksStatistics < ActiveRecord::Migration[7.0]
  def change
    create_table :user_tasks_statistics do |t|
      t.references :user, null: false, foreign_key: true
      t.date :first_completed_all_tasks
      t.integer :streak

      t.timestamps
    end
  end
end
