# == Schema Information
#
# Table name: user_managers
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  image                  :string
#  name                   :string
#  nickname               :string
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'rails_helper'

RSpec.describe UserManager, type: :model do
  describe '#create_user_for_google' do
    let(:data) do
      OpenStruct.new(email: 'user1@ribon.io', provider: 'google_oauth2')
    end

    it 'creates the UserManager in google with the correct params' do
      expect { described_class.create_user_for_google(data) }.to change(described_class, :count).by(1)
    end
  end
end
