FactoryBot.define do
  factory :story do
    title { 'Story' }
    description { 'Description' }
    non_profit_id { 1 }
    position { 1 }
    active { true }
  end
end
