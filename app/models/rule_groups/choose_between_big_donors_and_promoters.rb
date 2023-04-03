# RULE DESCRIPTION:
# - If all promoters (small donors) have less than 50% of the total money,
#   they will be chosen based on the percent.
#
#   Example: If the total money is 1000, and the promoters have 400,
#   the promoters will have 40% of change to be chosen.
#
# ------------
#
# - If the promoters have more than 50% of the total money,
#   the promoters will have 50% of change to be chosen. (limiter)
#
#   Example: If the total money is 1000, and the promoters have 600,
#   the promoters will have 50% of change to be chosen.
#
# if the chosen one is a promoter, the return will be a single promoter
# if the chosen one is a big donor, the return will be the while big donors group (to be picked later)
#
#

class ChooseBetweenBigDonorsAndPromoters < RuleGroup
  PRIORITY = 2

  def call(input = {})
    return big_donors_response if contributions_from_promoters.empty?
    return promoters_response  if contributions_from_big_donors.empty?
  
    case rand
    when 0..limited_promoters_percent
      promoters_response
    when limited_promoters_percent..1
      big_donors_response
    end
  end

  private

  def big_donors_response
    {
      chosen: contributions_from_big_donors,
      found: false,
    }
  end

  def promoters_response
    {
      chosen: contributions_from_promoters.sample,
      found: true,
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