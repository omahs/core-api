class RuleGroup
  def initialize(ribon, non_profit)
    @ribon = ribon
    @non_profit = non_profit
  end

  def self.rules_set
    ObjectSpace.each_object(Class).select { |klass| klass < self }.sort_by { |klass| klass::PRIORITY }
  end

  # there are some auxiliary methods. We need to move them to another place

  def contributions_from_big_donors
    base_contributions.from_big_donors
  end

  def contributions_from_promoters
    base_contributions.from_unique_donors
  end

  def base_contributions
    Contribution.all
  end

  def promoters_total_payments
    total_payments_from(contributions_from_promoters)
  end

  def big_donors_total_payments
    total_payments_from(contributions_from_big_donors)
  end

  def total_payments_from(contributions)
    contributions.sum { |contribution| contribution.contribution_balance.tickets_balance_cents }
  end
end