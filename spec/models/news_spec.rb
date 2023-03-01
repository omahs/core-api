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
require 'rails_helper'

RSpec.describe News, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
