# == Schema Information
#
# Table name: articles
#
#  id           :bigint           not null, primary key
#  published_at :datetime
#  title        :string
#  visible      :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  author_id    :bigint           not null
#
FactoryBot.define do
  factory :article do
    author { build(:author) }
    title { "My article" }
    published_at { "2023-03-01 15:42:30" }
    visible { false }
  end
end
