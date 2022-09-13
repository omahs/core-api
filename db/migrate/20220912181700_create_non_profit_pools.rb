class CreateNonProfitPools < ActiveRecord::Migration[7.0]
  def change
    create_table :non_profit_pools do |t|
      t.references :non_profit, null: false, foreign_key: true
      t.references :pool, null: false, foreign_key: true
    end
  end
end
