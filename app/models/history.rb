# == Schema Information
#
# Table name: histories
#
#  id              :bigint           not null, primary key
#  total_donations :bigint
#  total_donors    :bigint
#
class History < ApplicationRecord
  validates :total_donors, :total_donations, presence: true
end
