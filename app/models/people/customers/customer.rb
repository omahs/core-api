# == Schema Information
#
# Table name: customers
#
#  id            :uuid             not null, primary key
#  customer_keys :jsonb
#  email         :string           not null
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  person_id     :uuid
#  tax_id        :string
#  user_id       :bigint
#
# Indexes
#
#  index_customers_on_person_id  (person_id)
#  index_customers_on_user_id    (user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (person_id => people.id)
#
class Customer < ApplicationRecord
  include UuidHelper

  belongs_to :user
  belongs_to :person

  validates :email, presence: true
  validates :name, presence: true
end
