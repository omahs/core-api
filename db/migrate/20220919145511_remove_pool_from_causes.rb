class RemovePoolFromCauses < ActiveRecord::Migration[7.0]
  def change
    remove_reference :causes, :pool, null: false, foreign_key: true
  end
end
