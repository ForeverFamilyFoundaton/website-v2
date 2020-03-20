Stripe.api_key = Rails.application.credentials.stripe[:private_key]
StripeEvent.signing_secret = Rails.application.credentials.stripe[:signing_secret]

ActiveSupport.on_load(:active_record) do
  StripeEvent.configure do |events|
    events.all Stripe::EventLogger.new(Rails.logger)
  end
end
