class UsersController < ApplicationController
  before_action :authenticate_user!

  layout 'registration'

  def show
    @plan = Plan.first
    @profile_preferences = Preference.profile_preferences
  end
end
