module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      ::Badge::DONATION_BADGES_ENTRYPOINTS.each do |entrypoint|
        grant_on('api/v1/donations#create', badge: "#{entrypoint}-donation", model_name: 'Donation',
                                            to: :action_user) do |donation|
          donation.user.donations.count >= entrypoint
        end
      end
    end
  end
end
