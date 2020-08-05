RSpec.describe FamilyMember do
  it { is_expected.to belong_to :family }
  it { is_expected.to have_one :user }
end
