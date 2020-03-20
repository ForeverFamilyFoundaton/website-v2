RSpec.describe InviteFamilyMember do
  let(:user) { users(:homer) }
  let(:invite_family_member) { described_class.new(params: params, invitor: user) }
  let(:email) { Faker::Internet.email }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:params) do
    {
      email: email,
      first_name: first_name,
      last_name: last_name,
      role: FamilyMemberInvitation::ROLE_OPTIONS.sample
    }
  end

  describe '#call' do
    it 'creates a invited user' do
      expect { invite_family_member.call }.to change(User, :count).by 1
    end

    it "associates the invited user with the invitor's family" do
      invite_family_member.call
      invitee = User.find_by email: email
      expect(invitee.family).to eq user.family
    end
  end
end
