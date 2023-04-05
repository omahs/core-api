# frozen_string_literal: true

class DonationQueries
  attr_reader :cause

  def initialize(cause:)
    @cause = cause
  end

  def amount_free_donations
    sql = %(
      SELECT SUM(value) as sum FROM donations
      LEFT JOIN non_profits ON non_profits.id = donations.non_profit_id
      LEFT JOIN causes ON causes.id = non_profits.cause_id
      WHERE causes.id = #{cause.id})

    Donation.find_by_sql(sql)
  end

  def amount_free_donations_without_batch
    sql = %(
      SELECT SUM(value) as sum FROM donations
      LEFT JOIN non_profits ON non_profits.id = donations.non_profit_id
      LEFT JOIN causes ON causes.id = non_profits.cause_id
      LEFT JOIN donation_batches ON donation_batches.donation_id = donations.id
      WHERE causes.id = #{cause.id}
      AND donation_batches.id is null)

    Donation.find_by_sql(sql)
  end
end
