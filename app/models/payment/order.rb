class Order
  attr_accessor :id, :customer, :gateway, :payment, :payment_method, :offer, :card

  def initialize(params = {})
    @id             = params.id
    @payment        = params.payment
    @gateway        = params.gateway
    @card           = params.card
    @customer       = params.payment&.customer
    @payment_method = params.payment&.payment_method
    @offer          = params.payment&.offer
  end

  def self.from(payment, card = nil)
    params = {
      id: payment.id,
      gateway: payment&.offer&.gateway&.to_sym,
      customer: payment&.customer,
      payment: payment,
      payment_method: payment&.payment_method,
      offer: payment&.offer,
      card: card
    }

    new(params)
  end
end
