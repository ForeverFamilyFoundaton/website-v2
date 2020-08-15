class UserPreferenceSelectionsController < ApplicationController
  before_action :authenticate_user!

  def update
    current_user.update! preferences: Preference.find(params[:preference_ids])
    redirect_to user_path(current_user), notice: t('.success')
  end
end
