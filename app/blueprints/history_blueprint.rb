class HistoryBlueprint < Blueprinter::Base
  fields :total_donors

  field :total_donations do |_history, options|
    if options[:language] == 'pt-BR'
      options[:total_brl]
    else
      options[:total_usd]
    end
  end

  view :donors do
    excludes :total_donations
  end

  view :donations do
    excludes :total_donors
  end
end
