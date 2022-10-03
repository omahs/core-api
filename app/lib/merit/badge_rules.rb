module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      grant_on('api/v1/donations#create', badge: 'first-donation', model_name: 'Donation',
                                          to: :action_user) do |donation|
        donation.user.donations.count >= 1
      end

      grant_on('api/v1/donations#create', badge: 'twenty-donations', model_name: 'Donation',
                                          to: :action_user) do |donation|
        donation.user.donations.count >= 20
      end
    end
  end
end
