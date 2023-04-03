class ChooseBetweenBigDonorsAndPromoters < RuleGroup
  PRIORITY = 1

  def call(input = {})
    chosen_contributions = input[:chosen]

    return big_donors_response(chosen_contributions) if contributions_from_promoters(chosen_contributions).empty?
    return promoters_response(chosen_contributions)  if contributions_from_big_donors(chosen_contributions).empty?

    case rand
    when 0..limited_promoters_percent
      promoters_response(chosen_contributions)
    when limited_promoters_percent..1
      big_donors_response(chosen_contributions)
    end
  end

  private

  def contributions_from_big_donors(chosen_contributions)
    chosen_contributions.from_big_donors
  end

  def contributions_from_promoters(chosen_contributions)
    chosen_contributions.from_unique_donors
  end

  def big_donors_response(chosen_contributions)
    {
      chosen: contributions_from_big_donors(chosen_contributions),
      found: false
    }
  end

  def promoters_response(chosen_contributions)
    {
      chosen: contributions_from_promoters(chosen_contributions),
      found: false
    }
  end

  def promoters_percent
    percent = promoters_total_payments / (big_donors_total_payments + promoters_total_payments)

    percent.nan? ? 0 : percent
  end

  def limited_promoters_percent
    @promoters_percent ||= promoters_percent

    @promoters_percent > 0.5 ? 0.5 : @promoters_percent
  end

  def big_donors_percent
    1 - limited_promoters_percent
  end
end
