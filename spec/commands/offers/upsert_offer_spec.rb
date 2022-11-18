# frozen_string_literal: true

require 'rails_helper'

describe Offers::UpsertOffer do
  describe '.call' do
    subject(:command) { described_class.call(offer_params) }

    context 'when create with the right params' do
      let(:offer_params) do
        {
          currency: 'brl',
          price_cents: '1',
          gateway: 'stripe',
          external_id: 'id_123'
        }
      end

      context 'when create and have success' do
        it 'creates a new offer' do
          command
          expect(Offer.count).to eq(1)
        end

        it 'creates a offer gateway' do
          command
          expect(OfferGateway.count).to eq(1)
        end
      end
    end

    context 'when update with the right params' do
      let(:offer) { create(:offer) }
      let(:offer_params) do
        {
          id: offer.id,
          currency: 'brl',
          price_cents: '1',
          gateway: 'stripe',
          external_id: 'id_1234'
        }
      end

      it 'updates the cause with a new name' do
        command
        expect(offer.reload.external_id).to eq('id_1234')
      end
    end
  end
end
