FactoryBot.define do
  factory :integration do
    name { 'Renner' }
    wallet_address { '0x001' }
    url { 'https://renner.com' }

    before(:create) do |integration|
      image_path = Rails.root.join('vendor/assets/ribon_logo.png')

      integration.logo.attach(io: File.open(image_path),
                              filename: 'ribon_logo.png',
                              content_type: 'image/png')
    end
  end
end
