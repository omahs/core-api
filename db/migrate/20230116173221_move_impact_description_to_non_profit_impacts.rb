class MoveImpactDescriptionToNonProfitImpacts < ActiveRecord::Migration[7.0]
  def up
    add_column :non_profit_impacts, :impact_description, :text
    execute "UPDATE mobility_string_translations mst SET translatable_id = (SELECT id from non_profit_impacts npi WHERE npi.non_profit_id = mst.translatable_id) WHERE mst.translatable_type = 'NonProfit' AND mst.key = 'impact_description'"
    execute "UPDATE mobility_string_translations mst SET translatable_type = 'NonProfitImpact' WHERE mst.translatable_type = 'NonProfit' AND mst.key = 'impact_description'"
   
    remove_column :non_profits, :impact_description

  end

  def down 
    add_column :non_profits, :impact_description, :text
    execute "UPDATE mobility_string_translations mst SET translatable_id = (SELECT non_profit_id from non_profit_impacts npi WHERE npi.id = mst.translatable_id) WHERE mst.translatable_type = 'NonProfitImpact' AND mst.key = 'impact_description'"
    execute "UPDATE mobility_string_translations mst SET translatable_type = 'NonProfit' WHERE mst.translatable_type = 'NonProfitImpact' AND mst.key = 'impact_description'"
   
    remove_column :non_profit_impacts, :impact_description
  end
end
