# == Schema Information
#
# Table name: vouchers
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  donation_id    :bigint
#  external_id    :string
#  integration_id :bigint           not null
#
require 'rails_helper'

RSpec.describe Voucher, type: :model do
  describe '.validations' do
    subject { build(:voucher) }

    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_uniqueness_of(:external_id).scoped_to(:integration_id) }
  end

  describe '#callback_url' do
    subject(:voucher) { build(:voucher, external_id: 'external_id') }

    it 'returns the callback url' do
      host = Rails.application.routes.default_url_options[:host]

      expect(voucher.callback_url).to eq "#{host}/vouchers/external_id"
    end
  end
end
