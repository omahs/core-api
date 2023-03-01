FactoryBot.define do
  factory :article do
    author { nil }
    title { "My article" }
    published_at { "2023-03-01 15:42:30" }
    visible { false }
  end
end
