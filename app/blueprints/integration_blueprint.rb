class IntegrationBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :name, :unique_address, :status, :integration_address,
         :ticket_availability_in_minutes

  association :new_integration_wallet, blueprint: IntegrationWalletBlueprint
end
