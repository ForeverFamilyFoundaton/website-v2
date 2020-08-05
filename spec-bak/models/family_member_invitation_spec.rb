RSpec.describe FamilyMemberInvitation do
  let(:existing_user) { users(:homer) }

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_presence_of :role }
  it { is_expected.to allow_value(Faker::Internet.email).for :email }
  it { is_expected.not_to allow_value(Faker::Lorem.word).for :email }

  it 'requires email to be unique' do
    expect(User.new(email: existing_user.email).valid?).to be false
  end
end
