RSpec.describe User do
  let(:valid_params) {{first_name: 'John', last_name: 'Doe',
    email: 'user@example.com', password: 'testing'}}

  it { should have_one :address }
  it { should have_many :family_members }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :membership_number }
  it { should have_many :preferences }
  it { should have_many :profile_preferences }
  it { should have_many :subscription_preferences }
  it { should have_many :adg_preferences }
  it { should have_many(:categories).through(:user_categories) }

  it { should_not allow_mass_assignment_of :crypted_password }
  it { should_not allow_mass_assignment_of :password_salt }
  it { should_not allow_mass_assignment_of :single_access_token }
  it { should_not allow_mass_assignment_of :perishable_token }
  it { should_not allow_mass_assignment_of :login_count }
  it { should_not allow_mass_assignment_of :failed_login_count }
  it { should_not allow_mass_assignment_of :last_request_at }
  it { should_not allow_mass_assignment_of :current_login_at }
  it { should_not allow_mass_assignment_of :last_login_at }
  it { should_not allow_mass_assignment_of :current_login_ip }
  it { should_not allow_mass_assignment_of :last_login_ip }


  describe '#family_members' do
    let(:user) { users(:homer) }
    let(:family) { user.family }
    let(:family_members) { family.members }

    it 'returns all family members except self' do
      expect(user.family_members).to match_array (family_members - [user])
    end
  end

  describe '#family_owner' do
    context 'when owner' do
      let(:user) { users(:marge) }

      it 'returns true' do
        expect(user.family_owner?).to be true
      end
    end

    context 'when NOT owner' do
      let(:user) { users(:homer) }

      it 'returns false' do
        expect(user.family_owner?).to be false
      end
    end
  end

end
