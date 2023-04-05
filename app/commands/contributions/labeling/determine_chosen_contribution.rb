module Contributions
  module Labeling
    class DetermineChosenContribution < ApplicationCommand
      prepend SimpleCommand
      attr_accessor :donation

      def initialize(donation:)
        @donation = donation
      end

      def call
        rules = RuleGroup.rules_set

        apply_rules({
                      chosen: base_contributions,
                      found: false
                    }, rules)
      end

      private

      def base_contributions
        Contribution
          .with_tickets_balance_higher_than(donation.value)
      end

      def apply_rules(input, rules)
        return input if rules.empty?

        rule_result = rules.first.new(donation).call(input)

        if rule_result[:found]
          rule_result[:chosen]
        else
          new_input = rule_result
          apply_rules(new_input, rules[1..])
        end
      end
    end
  end
end