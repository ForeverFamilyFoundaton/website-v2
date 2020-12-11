class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plan, only: [:new, :create, :update]

  def new
    @cms_page = CmsPage.find_by reference_string: :subscriptions_new
  end

  def create
    current_user.update_card(params[:payment_method_id]) if params[:payment_method_id].present?
    current_user.subscribe @plan.stripe_id

    redirect_to user_path(current_user), notice: 'Thanks for subscribing!'
  rescue PaymentIncomplete => e
    redirect_to payment_path(e.payment_intent.id)
  end

  def destroy
    current_user.subscription.cancel
    redirect_to subscription_path, notice: 'Your subscription has been canceled.'
  end

  def resume
    current_user.subscription.resume
    redirect_to subscription_path, notice: 'Your subscription has been resumed.'
  end

  def show
    @cms_page = CmsPage.find_by reference_string: :subscriptions_show
    redirect_to user_path(current_user) unless current_user.subscription
    @subscription = current_user.subscription
  end

  private

  def set_plan
    @plan = Plan.find_by id: params[:plan_id]
    redirect_to pricing_path if @plan.nil?
  end
end
