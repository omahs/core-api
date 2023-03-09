class PersonBlueprint < Blueprinter::Base
  identifier :id

  association :customer, blueprint: CustomerBlueprint

  association :crypto_user, blueprint: CryptoUserBlueprint
end
