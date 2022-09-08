FactoryBot.define do
  factory :ribon_config do
    default_ticket_value { 100 }
    minimum_integration_amount { 10 }
    default_chain_id { 0x13881 }
  end
end
