class UserPreferenceSelectionsController < ApplicationController
  layout 'registration'
  before_action :authenticate_user!

  def edit
    @user_preference_options = Preference.profile_preferences
  end

  def update
    current_user.user_preference_selections.create user_preference_selection_params
    redirect_to user_path(current_user), notice: t('.success')
  end

  private
  def user_preference_selection_params
    params.require(:user).permit(:preference_ids)
  end
end
