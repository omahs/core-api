require "rails_helper"

RSpec.describe Payment::Stripe::Service do
  describe '#purchase' do
    let(:service) { described_class.new.purchase(transaction) }

    context 'when params are valid', vcr: { cassette_name: "payment/stripe/transactiontransaction" } do
      let(:transaction) { build(:transaction) }

      it 'returns a external customer id' do
        expect(service[:external_customer_id]).not_to be_nil
      end

      it 'returns a external payment method id' do
        expect(service[:external_payment_method_id]).not_to be_nil
      end

      it 'returns a external subscription id' do
        expect(service[:external_subscription_id]).not_to be_nil
      end

      it 'returns a external invoice id' do
        expect(service[:external_invoice_id]).not_to be_nil
      end
    end

    context 'when params are invalid', vcr: { cassette_name: "payment/stripe/create_subscription_faild" } do
      card = Payment::Card.new(
        cvv: "411",
        name: "User Test",
        number: "4111111111111112",
        expiration_month: "08",
        expiration_year: "22"
      )

      let(:transaction) { build(:transaction, card: card) }

      it 'returns a external customer id' do
        expect { service }.to raise_error("Your card number is incorrect.")
      end
    end

    context "when the offer is unique" do
      let(:transaction) { Payment::Transaction.from(payment) }
      let(:payment) { build(:payment, payment_method: :credit_card, offer: offer) }
      let(:payment_method_double) { OpenStruct.new({ id: "pay_123" }) }
      let(:customer_double) { OpenStruct.new({ id: "cus_123" }) }
      let(:tax_double) { OpenStruct.new({ id: "tax_123" }) }
      let(:offer) { build(:offer, recurrence: :unique, offer_gateway_attributes: { gateway: "stripe" }) }

      before do
        allow(Stripe::PaymentMethod).to receive(:create).and_return(payment_method_double)
        allow(Stripe::Customer).to receive(:create).and_return(customer_double)
        allow(Stripe::Customer).to receive(:create_tax_id).and_return(tax_double)
      end

      it 'calls Stripe::PaymentIntent api' do
        expect(Stripe::PaymentIntent).to receive(:create).with({ amount: offer.price_cents,
                                                                 currency: offer.currency,
                                                                 payment_method: payment_method_double,
                                                                 customer: customer_double,
                                                                 confirm: true })

        service
      end
    end

    context "when the offer is monthly" do
      let(:transaction) { Payment::Transaction.from(payment) }
      let(:payment) { build(:payment, payment_method: :credit_card, offer: offer) }
      let(:offer) { build(:offer, recurrence: :monthly, offer_gateway_attributes: { gateway: "stripe" }) }
      let(:tax_double) { OpenStruct.new({ id: "tax_123" }) }

      before do
        allow(Stripe::PaymentMethod).to receive(:create).and_return(OpenStruct.new({ id: "pay_123" }))
        allow(Stripe::Customer).to receive(:create).and_return(OpenStruct.new({ id: "cus_123" }))
        allow(Stripe::Customer).to receive(:create_tax_id).and_return(tax_double)
      end

      it 'calls Stripe::Subscription api' do
        expect(Stripe::Subscription).to receive(:create).with({
          customer: "cus_123",
          items: [
            { price: offer.external_id }
          ]
        }).and_return(OpenStruct.new({ id: "sub_123" }))

        service
      end
    end
  end
end
