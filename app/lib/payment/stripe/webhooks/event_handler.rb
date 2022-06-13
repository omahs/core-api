module Payment
  module Stripe
    module Webhooks
      class EventHandler
        attr_reader :event

        def initialize(event)
          @event = event
        end

        def handle(event_type, callback)
          return unless event_type == event.type

          callback.call
        end
      end
    end
  end
end
