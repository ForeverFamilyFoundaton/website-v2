class InviteFamilyMember
  def initialize(params:, invitor:)
    @params = params
    @invitor = invitor
  end

  def call
    { status: invite_user && create_family_membership ? :success : :failed }
  end

  private

  attr_reader :params, :invitor, :invited_user

  def create_family_membership
    family_membership = invitor.family.family_memberships.create(
      user: invited_user,
      role: params[:role]
    )
    family_membership.persisted?
  end

  def invite_user
    @invited_user = User.invite!(
      {
        email: params[:email],
        first_name: params[:first_name],
        last_name: params[:last_name],
      }, invitor
    )
    invited_user.persisted?
  end
end
