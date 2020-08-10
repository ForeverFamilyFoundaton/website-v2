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

  describe '#has_preference?' do
    let(:result) { user.has_preference?(preference) }
    let(:preference) { preferences(:profile_1) }

    context 'with a selected preference' do
      before do
        user.user_preference_selections.create! preference: preference
      end

      it 'returns true' do
        expect(result).to be true
      end
    end

    context 'with an unselected preference' do
      it 'returns false' do
        expect(result).to be false
      end
    end
  end
end
