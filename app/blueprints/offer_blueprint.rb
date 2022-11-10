class OfferBlueprint < Blueprinter::Base
  identifier :id

  fields :currency, :subscription, :price_cents, :price_value, :active, :title, :position_order,
          :created_at, :updated_at

  field :price do |object|
    Money.new(object.price_cents, object.currency).format
  end

  view :minimal do
    excludes :subscription, :currency, :price_cents, :price_value, :active, :title, :position_order,
             :created_at, :updated_at
  end
end
