class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :get_announcement

  private

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def record_not_found(e)
    redirect_to root_path, notice: e.message
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def after_sign_in_path_for(resource)
    user_path resource
  end

  def get_announcement
    @current_announcement = Announcement.current
  end
end
