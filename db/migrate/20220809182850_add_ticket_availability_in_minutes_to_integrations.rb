class AddTicketAvailabilityInMinutesToIntegrations < ActiveRecord::Migration[7.0]
  def change
    add_column :integrations, :ticket_availability_in_minutes, :integer
  end
end
