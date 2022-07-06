require 'rails_helper'

RSpec.describe 'Api::V1::Payments::Cryptocurrency', type: :request do

  let(:create_order_command_double) do
    command_double(klass: ::Givings::Payment::CreateOrder)
  end

  before do
    allow(::Givings::Payment::CreateOrder)
      .to receive(:call).and_return(create_order_command_double)
  end

  describe 'POST /cryptocurrency' do
    subject(:request) { post '/api/v1/payments/cryptocurrency', params: }

    let(:params) do
      { email: 'user@test.com', transaction_hash: '0xFFFF', amount: '5.00' }
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

  describe 'PUT /cryptocurrency' do
    subject(:request) { put '/api/v1/payments/cryptocurrency', params: }

    let(:customer) { build(:customer) }
    let(:customer_payment) { build(:customer_payment, customer:) }
    let!(:customer_payment_blockchain) { build(:customer_payment_blockchain, customer_payment:, transaction_hash: '0xFFFF') }

    before do
      allow(CustomerPaymentBlockchain).to receive(:find_by).and_return(customer_payment_blockchain)
    end

    context 'when the request is successful' do
      let(:params) do
        { status: 'success', transaction_hash: '0xFFFF' }
      end

      it 'returns http status no content (updated)' do
        request

        expect(response).to have_http_status 204
        expect(customer_payment_blockchain.treasure_entry_status).to eq('success')
      end
    end

    context 'when the request is failed due to invalid status' do
      let(:params) do
        { status: 'not_valid_status', transaction_hash: '0xFFFF' }
      end

      it 'returns http status unprocessable entity' do
        request

        expect(response).to have_http_status :unprocessable_entity
      end

      it 'not change the status of the transaction' do
        request

        expect(customer_payment_blockchain.treasure_entry_status).to eq('processing')
      end
    end

    context 'when the request is failed due to invalid status' do
      before do
        allow(CustomerPaymentBlockchain).to receive(:find_by).and_return(nil)
      end

      let(:params) do
        { status: 'success', transaction_hash: '0xINVALID' }
      end

      it 'returns http status unprocessable entity' do
        request

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
