module Payment
  class Transaction
    attr_accessor :id, :customer, :gateway, :payment, :payment_method, :offer, :card

    def initialize(params = {})
      self.id              = params[:id]
      self.payment         = params[:payment]
      self.customer        = params[:customer] || payment&.customer
      self.payment_method  = params[:payment_method] || payment&.payment_method
      self.gateway         = params[:gateway]
      self.offer           = params[:offer] || payment&.offer
      self.card            = params[:card]
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
end