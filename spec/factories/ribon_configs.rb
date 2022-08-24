FactoryBot.define do
  factory :ribon_config do
    default_ticket_value { 1 }
    minimum_integration_amount { 1 }
    default_chain_id { 80_001 }
  end
end
