FactoryBot.define do
  factory :non_profit do
    name { 'Evidence Action' }
    wallet_address { '0x000' }
    impact_description { 'Days of water' }
    link { 'https://evidenceaction.org' }
  end
end
