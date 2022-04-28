class AddDescriptionToNonProfits < ActiveRecord::Migration[7.0]
  def change
    add_column :non_profits, :description, :text
  end
end
