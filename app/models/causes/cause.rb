# == Schema Information
#
# Table name: causes
#
#  id      :bigint           not null, primary key
#  name    :string
#  pool_id :bigint           not null
#
class Cause < ApplicationRecord
  belongs_to :pool
  has_many :non_profits

  validates :name, presence: true
end
