Stripe.api_key = Rails.application.credentials.stripe_secret_key
StripeEvent.signing_secret = Rails.application.credentials.stripe_secret_key

ActiveSupport.on_load(:active_record) do
  StripeEvent.configure do |events|
    events.all Stripe::EventLogger.new(Rails.logger)
  end
end
