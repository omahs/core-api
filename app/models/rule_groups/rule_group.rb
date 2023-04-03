class RuleGroup
  def initialize(ribon, non_profit)
    @ribon = ribon
    @non_profit = non_profit
  end

  def self.rules_set
    ObjectSpace.each_object(Class).select { |klass| klass < self }.sort_by { |klass| klass::PRIORITY }
  end

  # there are some auxiliary methods. We need to move them to another place

  def big_donors
    BigDonor.all
  end

  def promoters
    @ribon.people.select do |person|
      person_payments(person).sum(&:amount) < 10_000_00 && person_allowed?(person)
    end
  end

  def promoters_total_payments
    promoters.sum { |person| person_payments(person).sum(&:amount) }
  end

  def big_donors_total_payments
    big_donors.sum { |person| person_payments(person).sum(&:amount) }
  end

  def has_enough_funds?(person, non_profit)
    person_balance(person) >= non_profit.default_ticket
  end

  def person_balance(person)
    person_payments(person).sum(&:amount) - person_transaction_tags(person).sum(&:amount)
  end

  def person_payments(person)
    @ribon.person_payments.select { |t| t.person == person }
  end

  def person_transaction_tags(person)
    @ribon.transaction_tags.select { |t| t.person == person }
  end

  def person_allowed?(person)
    person_balance(person) >= @non_profit.default_ticket
  end
end