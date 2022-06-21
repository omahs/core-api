class Order
  attr_accessor :id, :customer, :gateway, :payment, :payment_method, :offer, :card

  def initialize(params = {})
    self.id      = params.id
    self.payment = params.payment
    self.gateway = params.gateway
    self.card    = params.card

    initialize_payment_attributes(params.payment)
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

  private

  def initialize_payment_attributes(payment)
    self.customer       = payment&.customer
    self.payment_method = payment&.payment_method
    self.offer          = payment&.offer
  end
end
