# Purpose: Determine the chosen person for a Transaction Tag
# 
# How to use: DetermineChosenPerson.new(ribon, non_profit).call
# 
# How it works: It will choose a person based on the following rules:
# 1. If the person has donated more than 10k, it will be chosen 50% of the time
# 2. If the person has donated less than 10k, it will be chosen 50% of the time
# 3. If there are no people that have donated more than 10k, it will choose a person randomly
#
# How to improve: This class is doing too much. It should be split into smaller classes, specially the choose_rule_grops method.
#
#
# RULE GROUPS STRUCTURE
#
# 1 - MAKE IT BE 50/50 AT FIRST, OR FULL BIG DONORS DEPENDING OF THE AMOUNT OF PAYMENTS
# 2 - THE BIG DONORS SLICE IS DISTRIBUTED PROPORTIONALY TO EACH AMOUNT
# 3 - IF SOME BIG DONOR HAVE 10% TO BE USED, HE WILL BE PRIORITIZED
#
#
# ASSUMPTIONS I MADE: 
# THE 3RD RULE (TO CHECK IF SOME BIG DONOR HAS -10%) NEEDS TO RUN FIRST AND RETURN THEM
# THE 1ST AND 2ND RULE NEEDS TO RUN TOGETHER. LETS SUPPOSE THE FOLLOWING SCENERIES:
#
# FIRST ONE:
#
#        1 - ALL PROMOTERS HAVE $30.000
#        2 - RICHARLISON   HAVE $30.000
#        3 - LIONEL MESSI  HAVE $40.000
#        X - TOTAL             $100.000
#
# WHEN THE SUM OF ALL PROMOTERS IS LOWER THAN ALL BIG DONORS, THEY CAN BE TREATED AS A
# HUGE BIG DONOR. SO:
#
#        1 - ALL PROMOTERS WILL BE CHOSEN 30% OF TIME
#        2 - RICHARLISON   WILL BE CHOSEN 30% OF TIME
#        3 - LIONEL MESSI  WILL BE CHOSEN 40% OF TIME
#        X - TOTAL                       100%
#
#
# SECOND ONE:
#
#        1 - ALL PROMOTERS HAVE $60.000
#        2 - RICHARLISON   HAVE $30.000
#        3 - LIONEL MESSI  HAVE $10.000
#        X - TOTAL             $100.000
#
# ALL PROMOTERS HAVE MORE THAN ALL BIG DONORS, SO IT WILL BE:
#
#        1 - ALL PROMOTERS WILL BE CHOSEN 50%   OF TIME
#        2 - RICHARLISON   WILL BE CHOSEN 37,5% OF TIME
#        3 - LIONEL MESSI  WILL BE CHOSEN 12,5% OF TIME
#        X - TOTAL                       100%
#
# THE PROMOTERS PROBABILITY IS LIMITED TO 50%, AND THE ORHERS 50% ARE DISTRIBUTED
# PROPORTIONALLY PER BIG DONOR
#
#

# require_relative 'rule_groups/rule_group'
# require_relative 'rule_groups/choose_between_big_donors_and_promoters'
# require_relative 'rule_groups/fetch_big_donors_with_low_remaining_amount'
# require_relative 'rule_groups/pick_big_donor_based_on_money'

module Contributions
  module Labeling
    class DetermineChosenPerson # TODO change this class name
      attr_accessor :ribon, :non_profit

      def initialize(ribon, non_profit)
        @ribon      = ribon
        @non_profit = non_profit
      end

      def call
        rules = RuleGroup.rules_set

        apply_rules({}, rules)
      end

      private

      def apply_rules(input, rules)
        return input if rules.empty?
        
        rule_result = rules.first.new(ribon, non_profit).call(input)
        if rule_result[:found]
          return rule_result[:chosen]
        else
          new_input = rule_result
          return apply_rules(new_input, rules[1..-1])
        end
      end
    end
  end
end
