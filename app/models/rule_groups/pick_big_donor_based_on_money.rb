# RULE DESCRIPTION:
# - If the return of previous rule is an array of big donors, this rule will be called
# - The big donor will chosen by calculating the percent of his money using probability

require_relative 'rule_group'

class PickBigDonorBasedOnMoney < RuleGroup
  PRIORITY = 3

  def call(input = {})
    big_donors_group = input[:chosen]
    chosen = if big_donors_group.is_a?(Array) && !big_donors_group.empty?
      c_debug(:green, "PICKED BIG DONOR BASED ON MONEY")
      big_donors_group.sample
    else
      c_debug(:red, "PROMOTER PICKER IN THE WRONG PLACE???????")
      promoters.sample
    end

    {
      chosen: chosen,
      found: true,
    }
  end

  private

  def calculate_big_donors_probability_based_on_money
    # we need to calculate the probability of each big donor to be chosen
    # the probability is based on the percent of his money
    # Example: If the total big donors money is 1000, and the big donor has 400,
    # the big donor will have 40% of change to be chosen.
  end
end