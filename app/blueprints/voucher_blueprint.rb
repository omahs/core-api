class VoucherBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :external_id, :callback_url

  association :donation, blueprint: DonationBlueprint, view: :minimal
end
