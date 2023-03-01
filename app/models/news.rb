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
class News < ApplicationRecord
  belongs_to :author
  has_one_attached :image
end
