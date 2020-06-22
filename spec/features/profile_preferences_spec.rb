RSpec.feature 'As a registered user' do
  let(:user) { users(:homer) }
  let(:selected_preference) { preferences(:one) }
  let(:unselected_preference) { preferences(:two) }

  before do
    user.user_preference_selections.create! preference: selected_preference
    login_as user
    visit user_path(user)
  end

  scenario 'I can fill out my Profile Preferences', :js do
    expect(page).to have_checked_field selected_preference.name
    expect(page).not_to have_checked_field unselected_preference.name
    accept_confirm do
      check unselected_preference.name
    end
    expect(page).to have_content I18n.t('user_preference_selections.update.success')
    expect(page).to have_checked_field unselected_preference.name
    accept_confirm do
      uncheck unselected_preference.name
    end
    expect(page).to have_content I18n.t('user_preference_selections.update.success')
    expect(page).not_to have_checked_field unselected_preference.name
  end
end
