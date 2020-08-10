RSpec.feature 'As an Admin user' do
  let(:user) { users(:admin) }
  let(:profile_preference_1) { preferences(:profile_1) }
  let(:subscription_preference_1) { preferences(:subscription_1) }
  let(:name) { Faker::Lorem.word }

  before do
    login_as user
    visit admin_preferences_path
  end

  scenario 'I can manage Preferences' do
    click_on 'New Preference'
    fill_in 'Name', with: name
    select 'Profile', from: 'Preference type'
    click_on 'Create Preference'
    expect(page).to have_content 'Preference was successfully created.'
    visit admin_preferences_path
    expect(page).to have_content profile_preference_1.name
    expect(page).to have_content subscription_preference_1.name
  end
end
