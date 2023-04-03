# RULE DESCRIPTION:
# - If the return of previous rule is an array of big donors, this rule will be called
# - The big donor will chosen by calculating the percent of his money using probability

require_relative 'rule_group'

class PickBigDonorBasedOnMoney < RuleGroup
  PRIORITY = 3

  def call(input = {})
    big_donors_group = input[:chosen]
    chosen = if big_donors_group.is_a?(Array) && !big_donors_group.empty?
               chosen_big_donor(big_donors_group)
             else
               contributions_from_promoters.sample
    end

    {
      chosen:,
      found: true,
    }
  end

  private

  def chosen_big_donor(big_donors_group)
    return big_donors_group.sample

    case rand
    when 0..0.1
      # big donor 1
    when 0.1..0.3
      # big donor 2
    when 0.3..1
      # big donor 3
    end
  end

  def calculate_big_donors_probability_based_on_money
    total_donations_from_big_donors = big_donors_total_payments

    contributions_from_big_donors.map do |contribution|
      {
        contribution.id => contribution.usd_value_cents / total_donations_from_big_donors,
      }
    end

    {
      1: "0.1",
      2: "0.2",
      3: "0.7"
    }
  end
end