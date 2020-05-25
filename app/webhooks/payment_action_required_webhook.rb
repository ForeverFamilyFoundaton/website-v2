class PaymentActionRequiredWebhook
  def call(event)
    object = event.data.object
    user = User.find_by(stripe_id: object.customer)
    subscription = Subscription.find_by(stripe_id: object.subscription)

    return if user.nil? || subscription.nil?

    UserMailer.payment_action_required(user, object.payment_intent, subscription).deliver_later
  end
end
