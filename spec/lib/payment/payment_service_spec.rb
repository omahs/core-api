require "rails_helper"

RSpec.describe Payment::PaymentService do
  let(:dummy_class) { Class.new { extend Payment::PaymentService } }

  describe 'stripe_service' do
    it { expect(dummy_class.stripe_service).to be_a(Payment::Stripe::Service) }
  end
end
