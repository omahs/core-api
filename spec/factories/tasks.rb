FactoryBot.define do
  factory :task do
    title { "My task" }
    actions { "event1, event2, event3" }
    rules { "reset_everyday" }
  end
end
