class FamilyMembersController < ApplicationController
  before_action :authenticate_user!

  def destroy
    family_member = current_user.family_members.find params[:id]
    family_member.destroy
    redirect_to user_path(current_user), notice: t('.success')
  end
end
