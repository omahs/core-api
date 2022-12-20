class HistoryBlueprint < Blueprinter::Base
  
  fields :total_donations, :total_donors

  view :donors do
    excludes :total_donations
  end

  view :donations do
    excludes :total_donors
  end
end
