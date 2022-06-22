# frozen_string_literal: true

require 'rails_helper'

describe Givings::Payment::CreateOrder do
  describe '.call' do
    subject(:command) { described_class.call(args) }

    let(:args) do
      { card:, email: 'user@test.com', tax_id: '111.111.111-11', offer_id: offer.id,
        payment_method: :credit_card, user:, operation: :subscribe }
    end
    let(:card) { build(:card) }
    let(:user) { create(:user) }
    let(:offer) { create(:offer) }

    context 'when there is no customer associated with the user' do
      it 'creates a new customer to the user' do
        expect { command }.to change(user.customers, :count).by(1)
      end
    end
  end
end
