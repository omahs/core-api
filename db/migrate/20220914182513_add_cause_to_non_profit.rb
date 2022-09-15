class AddCauseToNonProfit < ActiveRecord::Migration[7.0]
  def change
    add_reference :non_profits, :cause, foreign_key: true
  end
end
