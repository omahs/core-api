FactoryBot.define do
  factory :transaction, class: "Payment::Transaction" do
    initialize_with {
      Payment::Transaction.from(
        build(:payment),
        build(:card)
      )
    }
  end
end
