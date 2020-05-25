RSpec.describe User do
  let(:user) { users(:homer) }

  describe '#family_members' do
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
