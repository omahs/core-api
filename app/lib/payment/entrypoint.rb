module Payment
  class Entrypoint
    def initialize(gateway:)
      @gateway = gateway::PaymentProcessor.new
    end

    def process(operation:, payload:)
      @gateway.send(operation, payload)
    end
  end
end
