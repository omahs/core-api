# RULE DESCRIPTION:
# - If the return of previous rule is an array of big donors, this rule will be called
# - The big donor will chosen by calculating the percent of his money using probability

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
    probabilities = calculate_big_donors_probability_based_on_money(big_donors_group)
    contribution_id = select_contribution_id(probabilities)

    big_donors_group.find { |contribution| contribution.id == contribution_id }
  end

  def calculate_big_donors_probability_based_on_money(big_donors_group)
    total_donations_from_big_donors = big_donors_total_payments

    probabilities_hash = {}
    big_donors_group.each do |contribution|
      probabilities_hash[contribution.id] = contribution.usd_value_cents / total_donations_from_big_donors
    end

    probabilities_hash
  end

  def select_contribution_id(probabilities)
    # Generate a random number between 0 and 1
    random_number = rand

    # Iterate through the hash of probabilities
    cumulative_probability = 0
    probabilities.each do |contribution_id, probability|
      # Convert probability to float
      probability = probability.to_f

      # Add the probability to the cumulative probability
      cumulative_probability += probability

      # If the cumulative probability is greater than the random number,
      # return the corresponding user ID
      return contribution_id if random_number < cumulative_probability
    end

    # If no user has been selected, return nil
    nil
  end
end