class CreateNonProfitImpacts < ActiveRecord::Migration[7.0]
  def change
    create_table :non_profit_impacts do |t|
      t.references :non_profit, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :usd_cents_to_one_impact_unit

      t.timestamps
    end
  end
end
