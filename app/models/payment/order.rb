class Order
  attr_accessor :id, :customer, :gateway, :payment, :payment_method, :offer, :card, :operation

  def initialize(params = {})
    self.id        = params[:id]
    self.payment   = params[:payment]
    self.gateway   = params[:gateway]
    self.card      = params[:card]
    self.operation = params[:operation]

    initialize_payment_related_attributes(params)
  end

  def self.from(payment, card = nil, operation)
    params = {
      id: payment.id,
      gateway: payment&.offer&.gateway&.to_sym,
      customer: payment&.customer,
      payment:,
      payment_method: payment&.payment_method,
      offer: payment&.offer,
      card:,
      operation:
    }

    new(params)
  end

  private

  def initialize_payment_related_attributes(params)
    self.customer       = params[:customer]       || payment&.customer
    self.payment_method = params[:payment_method] || payment&.payment_method
    self.offer          = params[:offer]          || payment&.offer
  end
end
