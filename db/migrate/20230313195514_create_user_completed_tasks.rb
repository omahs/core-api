class CreateUserCompletedTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :user_completed_tasks, id: :uuid do |t|
      t.references :task, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :completed_at
      t.integer :completion_count

      t.timestamps
    end
  end
end
