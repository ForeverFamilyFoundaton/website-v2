module Stripe
  class EventLogger
    def initialize(logger)
      @logger = logger
    end

    def call(event)
      logger.info "STRIPE EVENT: #{event.type}:#{event.id}"
      logger.info event.inspect
    end

    private

    attr_reader :logger
  end
end
