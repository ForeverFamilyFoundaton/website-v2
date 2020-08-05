RSpec.describe UserPreferenceSelection do
  it { is_expected.to validate_uniqueness_of(:preference_id).scoped_to(:user_id) }
end
