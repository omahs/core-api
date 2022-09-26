# Use this hook to configure merit parameters
Merit.setup do |config|
  config.checks_on_each_request = true
end

# Create application badges (uses https://github.com/norman/ambry)
Rails.application.reloader.to_prepare do
  badge_id = 0
  badges = [
    {
      id: (badge_id += 1),
      name: 'just-registered',
      description: "You're now a Ribonite!",
      custom_fields: { category: 'onboarding' }
    }, {
      id: (badge_id += 1),
      name: 'first-donation',
      description: 'You just made your first donation!',
      custom_fields: { category: 'donation' }
    }, {
      id: (badge_id += 1),
      name: 'twenty-donations',
      description: 'You just made your twentieth donation!',
      custom_fields: { category: 'donation' }
    }, {
      id: (badge_id += 1),
      name: '10-days-streak',
      description: 'You donated 10 days in a row!',
      custom_fields: { category: 'donation' }
    }
  ]

  badges.each do |attrs|
    Merit::Badge.create! attrs
  end
end
