class Order
  attr_accessor :id, :person, :gateway, :payment, :payment_method, :offer, :card, :operation

  def initialize(params = {})
    self.id        = params[:id]
    self.payment   = params[:payment]
    self.gateway   = params[:gateway]
    self.card      = params[:card]
    self.operation = params[:operation]

    initialize_payment_related_attributes(params)
  end

  def self.from(payment, card = nil, operation = nil)
    params = {
      id: payment.id,
      gateway: payment&.offer&.gateway&.to_sym,
      person: payment&.person,
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
    self.person         = params[:person]         || payment&.person
    self.payment_method = params[:payment_method] || payment&.payment_method
    self.offer          = params[:offer]          || payment&.offer
  end
end
