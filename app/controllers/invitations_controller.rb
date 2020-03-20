class InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters

  def create
    result = InviteFamilyMember.new(invitation_params).call
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :accept_invitation,
      keys: [
        :first_name,
        :last_name,
        :role
      ]
    )
  end
end
