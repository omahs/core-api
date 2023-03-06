module Mailers
  class SendContributionReactivationEmailJob < ApplicationJob
    queue_as :default

    def perform(user:)
      contribution = user.last_contribution

      send_email(user, donations_count) if DONATIONS_COUNT_ENTRYPOINTS.include? donations_count
    end

    private

    def send_email(user, contribution)
      SendgridWebMailer.send_email(receiver: user.email,
                                   dynamic_template_data: {
                                     value: contribution.amount_cents,
                                     value_add: contribution.amount_cents * 0.02,
                                     name: contribution.receiver.name,
                                     currency: contribution.offer&.currency
                                   },
                                   template_name: "contribution_#{contribution.receiver_type}_template_id",
                                   language: user.language).deliver_later
    end
  end
end
