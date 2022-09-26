# Use this hook to configure merit parameters
Merit.setup do |config|
end

# Create application badges (uses https://github.com/norman/ambry)
Rails.application.reloader.to_prepare do
  badge_id = 0
  [{
    id: (badge_id = badge_id + 1),
    name: 'just-registered',
    description: "You're now a Ribonite!",
    custom_fields: { category: 'onboarding' }
  }, {
    id: (badge_id = badge_id + 1),
    name: 'first-donation',
    description: 'You just made your first donation!',
    custom_fields: { category: 'donation' }
  }].each do |attrs|
    Merit::Badge.create! attrs
  end
end
