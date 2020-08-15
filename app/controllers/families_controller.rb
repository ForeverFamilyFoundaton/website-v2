class FamiliesController < ApplicationController
  def create
    @family = current_user.family.new family_params
  end

  def new
    @family = Family.new
  end

  def edit
  end

  private

  def family_params
    params.require(:family).permit(
      family_member_attributes: []
    )
  end
end
