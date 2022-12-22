# == Schema Information
#
# Table name: histories
#
#  id              :bigint           not null, primary key
#  total_donations :bigint
#  total_donors    :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class History < ApplicationRecord
  validates :total_donors, :total_donations, presence: true

  def total_donations_usd
    Currency::Converters.convert_to_usd(value: total_donations, from: 'BRL').round.to_f
  end
end
