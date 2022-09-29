class VoucherBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :external_id

  association :donation, blueprint: DonationBlueprint
end
