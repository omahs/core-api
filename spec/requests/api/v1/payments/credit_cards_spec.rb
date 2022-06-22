require 'rails_helper'

RSpec.describe 'Api::V1::Payments::CreditCards', type: :request do
  describe 'POST /subscribe' do
    subject(:request) { post '/api/v1/payments/credit_cards/subscribe', params: }

    let(:params) do
      { email: 'user@test.com', national_id: '111.111.111-11', offer_id: offer.id,
        country: 'Brazil', city: 'Brasilia', state: 'DF',
        card: { cvv: 555, number: '4222 2222 2222 2222', name: 'User Test',
                expiration_month: '05', expiration_year: '25' } }
    end
    let(:offer) { create(:offer) }
    let(:create_order_command_double) do
      command_double(klass: ::Givings::Payment::CreateOrder)
    end
    let(:credit_card_double) do
      CreditCard.new(cvv: params[:card][:cvv], number: params[:card][:number], name: params[:card][:name],
                     expiration_month: params[:card][:expiration_month],
                     expiration_year: params[:card][:expiration_year])
    end
    let(:user_double) { build(:user, email: 'user@test.com') }

    before do
      allow(::Givings::Payment::CreateOrder)
        .to receive(:call).and_return(create_order_command_double)
      allow(CreditCard).to receive(:new).and_return(credit_card_double)
      allow(User).to receive(:find_or_create_by).and_return(user_double)
    end

    it 'calls the CreateOrder command with right params' do
      request
      expected_params = { card: credit_card_double, email: 'user@test.com', national_id: '111.111.111-11',
                          offer_id: offer.id, operation: :subscribe, payment_method: :credit_card,
                          user: user_double }

      expect(::Givings::Payment::CreateOrder).to have_received(:call).with(expected_params)
    end

    context 'when the command is successful' do
      let(:create_order_command_double) do
        command_double(klass: ::Givings::Payment::CreateOrder, success: true)
      end

      it 'returns http status created' do
        request

        expect(response).to have_http_status :created
      end
    end

    context 'when the command is failure' do
      let(:create_order_command_double) do
        command_double(klass: ::Givings::Payment::CreateOrder, success: false, failure: true)
      end

      it 'returns http status created' do
        request

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
