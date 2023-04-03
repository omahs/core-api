# RULE DESCRIPTION:
#  - If some donor needs less than 10% to use all his money, he will be prioritized
#  - This is the cheapest rule we need to run. It should be the first one to run

require_relative 'rule_group'

class FetchBigDonorsWithLowRemainingAmount < RuleGroup
  PRIORITY = 1

  def call(input = {})
    
    return empty if big_donors.empty?

    allowed_big_donors = big_donors.select do |person|
      person_balance(person) < person_payments(person).sum(&:amount) * 0.1
    end

    return empty if allowed_big_donors.empty?

    {
      chosen: allowed_big_donors.sample,
      found: true,
    }
  end

  private

  def empty
    c_debug(:yellow, "No big donors with low remaining amount found");

    {
      chosen: nil,
      found: false,
    }
  end
end