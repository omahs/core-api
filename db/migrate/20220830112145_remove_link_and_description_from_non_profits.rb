class RemoveLinkAndDescriptionFromNonProfits < ActiveRecord::Migration[7.0]
  def change
    remove_column :non_profits, :link, :string
    remove_column :non_profits, :description, :text
  end
end
