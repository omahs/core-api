FactoryBot.define do
  factory :card, class: 'Payment::Card' do
    initialize_with do
      new(
        cvv: '411',
        number: '4111111111111111',
        name: 'User Test',
        expiration_month: '08',
        expiration_year: '22'
      )
    end
  end
end
