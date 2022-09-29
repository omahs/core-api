class ChangeUsdCentsToOneImpactUnitFromIntegerToDecimal < ActiveRecord::Migration[7.0]
  def change
    change_column :non_profit_impacts, :usd_cents_to_one_impact_unit, :decimal
  end
end
