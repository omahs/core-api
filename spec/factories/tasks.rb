# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  actions    :text
#  title      :string
#  type       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :task do
    title { 'My task' }
    actions { 'event1, event2, event3' }
    type { 'daily_task' }
  end
end
