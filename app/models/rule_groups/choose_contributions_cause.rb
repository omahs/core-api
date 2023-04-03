class ChooseContributionsCause < RuleGroup
  PRIORITY = 2

  def call(input = {})
    chosen_contributions = input[:chosen]

    contributions_by_cause(chosen_contributions)

    {
      chosen: contributions_by_cause(chosen_contributions),
      found: false
    }
  end

  private

  def contributions_by_cause(chosen_contributions)
    chosen_contributions.where(receiver: @donation.cause)
  end
end
