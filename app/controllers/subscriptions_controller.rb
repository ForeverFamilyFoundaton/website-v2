class SubscriptionsController < ApplicationController
  layout 'registration'

  before_action :force_turbolinks_reload

  def new; end

  def create
    customer = Stripe::Customer.create(
      payment_method: params[:payment_method],
      email: current_user.email,
      invoice_settings: {
        default_payment_method: params[:payment_method],
      },
    )
    subscription = Stripe::Subscription.create(
      customer: customer.id,
      items: [
        {
          plan: Rails.application.credentials.stripe[:subscription_id],
        },
      ],
      expand: ['latest_invoice.payment_intent'],
      payment_behavior: :allow_incomplete
    )
    current_user.update! stripe_subscription_id: subscription.id
    render json: subscription, status: :created
  rescue => e
    render json: { error: e.message, status: 422 }
  end

  def show
    @subscription = Stripe::Subscription.retrieve(current_user.stripe_subscription_id)
  end

  private

  def force_turbolinks_reload
    @force_turbolinks_reload = true
  end
end
