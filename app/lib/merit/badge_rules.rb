module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      # If it creates user, grant badge
      # Should be "current_user" after registration for badge to be granted.
      # Find badge by badge_id, badge_id takes presidence over badge
      # grant_on 'users#create', badge_id: 7, badge: 'just-registered', to: :itself
      # If it has 10 comments, grant commenter-10 badge
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
