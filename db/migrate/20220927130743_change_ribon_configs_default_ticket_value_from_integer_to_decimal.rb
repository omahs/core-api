class ChangeRibonConfigsDefaultTicketValueFromIntegerToDecimal < ActiveRecord::Migration[7.0]
  def change
    change_column :ribon_configs, :default_ticket_value, :decimal
  end
end
