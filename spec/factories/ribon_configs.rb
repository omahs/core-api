FactoryBot.define do
  factory :ribon_config do
    default_ticket_value { 1 }
    minimum_integration_amount { 1 }
  end
end
