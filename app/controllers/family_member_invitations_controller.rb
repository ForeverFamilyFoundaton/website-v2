class FamilyMemberInvitationsController < ApplicationController
  def create
    @family_member_invitation = FamilyMemberInvitation.new family_member_invitation_params
    render :new and return unless @family_member_invitation.valid?
    service_response = InviteFamilyMember.new(
      params: family_member_invitation_params,
      invitor: current_user
    ).call
    if service_response[:status] == :success
      redirect_to user_path(current_user), notice: t('.success')
    else
      render :new
    end
  end

  def new
    @family_member_invitation = FamilyMemberInvitation.new
  end

  private

  def family_member_invitation_params
    params.require(:family_member_invitation).permit(
      :role,
      :email,
      :first_name,
      :last_name
    )
  end
end

