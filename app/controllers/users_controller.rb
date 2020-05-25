class UsersController < ApplicationController
  before_action :authenticate_user!

  layout 'registration'

  def show
    @plan = Plan.first
  end
end
