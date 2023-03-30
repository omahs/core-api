# == Schema Information
#
# Table name: articles
#
#  id           :bigint           not null, primary key
#  language     :string
#  link         :string
#  published_at :datetime
#  title        :string
#  visible      :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  author_id    :bigint           not null
#
class Article < ApplicationRecord
  belongs_to :author
  has_one_attached :image
end
