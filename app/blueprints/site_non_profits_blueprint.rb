class SiteNonProfitsBlueprint < Blueprinter::Base
  fields :name

  field(:main_image) do |object|
    ImagesHelper.image_url_for(object.main_image, variant: { resize_to_fit: [800, 800],
                                                             saver: { quality: 95 }, format: :jpg })
  end

  field :description do |non_profit, options|
    if options[:language] == 'pt-BR'
      "Doe #{non_profit.impact_by_ticket} #{non_profit.impact_description_pt_br}"
    else
      "Donate #{non_profit.impact_by_ticket} #{non_profit.impact_description}"
    end
  end
end
