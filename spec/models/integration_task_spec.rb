# == Schema Information
#
# Table name: integration_tasks
#
#  id             :bigint           not null, primary key
#  description    :string
#  link           :string
#  link_address   :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  integration_id :bigint           not null
#
require 'rails_helper'

RSpec.describe IntegrationTask, type: :model do
  describe '.validations' do
    subject { build(:integration_task) }

    it { is_expected.to validate_presence_of(:description) }
  end
end
