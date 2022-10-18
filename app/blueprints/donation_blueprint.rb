class DonationBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :value, :impact, :impact_value

  association :non_profit, blueprint: NonProfitBlueprint, view: :extended
  association :integration, blueprint: IntegrationBlueprint
  association :user, blueprint: UserBlueprint
  association :donation_blockchain_transaction, blueprint: DonationBlockchainTransactionBlueprint

  view :minimal do
    excludes :integration, :updated_at
  end
end
