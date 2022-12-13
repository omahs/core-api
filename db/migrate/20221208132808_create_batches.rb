class CreateBatches < ActiveRecord::Migration[7.0]
  def change
    create_table :batches do |t|
      t.string :cid
      t.float :amount

      t.timestamps
    end
  end
end
