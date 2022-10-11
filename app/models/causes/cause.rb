# == Schema Information
#
# Table name: causes
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Cause < ApplicationRecord
  extend Mobility

  translates :name, type: :string

  has_many :non_profits

  validates :name, presence: true
end
