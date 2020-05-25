class PricingController < ApplicationController
  layout "registration"

  def show
    @plans = Plan.all
  end
end
