class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payment_intent

  def show
  end

  def update
    current_user.update_card(params[:payment_method_id]) if params[:payment_method_id].present?

    redirect_to user_path(current_user), notice: "Thanks for your payment"
  end

  private

  def set_payment_intent
    @payment_intent = Stripe::PaymentIntent.retrieve(params[:id])
  end
end
