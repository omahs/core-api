module Mailers
  class SendContributionReactivationEmailJob < ApplicationJob
    queue_as :default

    def perform(user:)
      contribution = user.last_contribution

      send_email(user, contribution) if contribution
    end

    private

    def send_email(user, contribution)
      SendgridWebMailer
        .send_email(receiver: user.email,
                    dynamic_template_data:
                      {
                        giving_value: giving_value(contribution),
                        giving_value_added: giving_value_added(contribution),
                        receiver_name: contribution.receiver.name,
                        current_date: Time.zone.now.strftime('%d/%m/%Y'),
                        impact: impact(contribution.receiver)
                      },
                    template_name: "contribution_#{contribution.receiver_type&.underscore}_template_id",
                    language: user.language).deliver_later
    end

    def giving_value(contribution)
      Money.new(contribution.amount_cents, contribution.currency&.to_sym).format
    end

    def giving_value_added(contribution)
      Money.new(contribution.amount_cents * 0.02, contribution.currency&.to_sym).format
    end

    def impact(non_profit)
      return unless non_profit.class.to_s == 'NonProfit'

      ::Impact::Normalizer.new(
        non_profit,
        non_profit.impact_by_ticket
      ).normalize.join(' ')
    end
  end
end
