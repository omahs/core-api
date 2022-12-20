class SiteNonProfitsBlueprint < Blueprinter::Base
  fields :name, :main_image

  field :description do |non_profit, options|
    if options[:language] == 'pt-BR'
      "Doe #{non_profit.impact_by_ticket} #{non_profit.impact_description_pt_br}"
    else
      "Donate #{non_profit.impact_by_ticket} #{non_profit.impact_description}"
    end
  end


end
