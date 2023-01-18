class SiteNonProfitsBlueprint < Blueprinter::Base
  field(:main_image) do |object|
    ImagesHelper.image_url_for(object.main_image)
  end

  field(:logo) do |object|
    ImagesHelper.image_url_for(object.logo)
  end

  field :description do |non_profit, options|
    if options[:language] == 'pt-BR'
      "Doe #{non_profit.impact_by_ticket} #{non_profit.impact_description_pt_br}"
    else
      "Donate #{non_profit.impact_by_ticket} #{non_profit.impact_description}"
    end
  end
end
