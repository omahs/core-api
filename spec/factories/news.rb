# == Schema Information
#
# Table name: news
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
  factory :news do
    author { build(:author) }
    title { "MyString" }
    published_at { "2023-03-01 10:35:22" }
    visible { false }
  end
end
