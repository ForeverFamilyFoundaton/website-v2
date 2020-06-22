RSpec.feature 'As a registered user' do
  let(:user) { users(:homer) }
  let(:selected_preference) { preferences(:one) }
  let(:unselected_preference) { preferences(:two) }

  before do
    user.user_preference_selections.create! preference: selected_preference
    login_as user
    visit user_path(user)
  end

  scenario 'I can fill out my ProfilePreferences' do
    within '.profile-preferences' do
      click_on 'Edit'
    end
    expect(page).to have_content selected_preference.name
    expect(page).not_to have_content unselected_preference.name
    check unselected_preference.name
    click_on 'Save'
    expect(page).to have_content I18n.t('profile_preferences.update.success')
    within '.profile-preferences' do
      expect(page).to have_content unselected_preference.name
    end
  end
end
