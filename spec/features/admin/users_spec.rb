RSpec.feature 'As an admin user' do
  let(:user) { users(:admin) }

  include_context 'User Profile Data'

  before do
    login_as user
    visit admin_users_path
  end

  scenario 'I can manage users' do
    click_on 'New User'
    fill_in 'First name', with: first_name
    fill_in 'Last name', with: last_name
    fill_in 'Email', with: home_email
    fill_in 'Password', with: password, match: :prefer_exact
    fill_in 'Password confirmation', with: password
    fill_in 'Address', with: street_address_1
    fill_in 'City', with: city
    fill_in 'State', with: state
    fill_in 'Zip', with: zip
    click_on 'Create User'
    expect(page).to have_content 'User was successfully created.'
    expect(page).to have_content first_name
  end

  scenario 'I can edit a user without needing the password' do
    within first('#index_table_users tbody tr') do
      click_on 'View'
    end
    click_on 'Edit User'
    click_on 'Update User'
    expect(page).to have_content('User was successfully updated.')
  end

  scenario "I see a preference column" do
    expect(page).to have_content "#{user.preferences.map(&:name).to_sentence}"
  end

  scenario 'CSV downloads contain association data' do
    click_on 'CSV'
    header = page.response_headers['Content-Disposition']
    expect(header).to match /^attachment/
    expect(header).to match /filename="users-#{Date.today}.csv"$/
    expect(page).to have_content 'Address: street'
    expect(page).to have_content 'Address: city'
    expect(page).to have_content 'Address: state'
    expect(page).to have_content 'Address: zip'
    expect(page).to have_content 'Address: country'
    expect(page).to have_content 'Preferences'
  end

  context 'with an unconfirmed, invalid User' do
    let(:unconfirmed_user) { users(:homer) }

    before do
      unconfirmed_user.update! confirmed_at: nil
      unconfirmed_user.update_column :first_name, nil
    end

    scenario "I can manually confirm a User" do
      visit current_path
      within first("#index_table_users tr#user_#{unconfirmed_user.id}") do
        within '.col-confirmed' do
          expect(page).to have_content 'No'
        end
        click_on 'View'
      end
      click_on 'Confirm'
      expect(page).to have_content(
        "Confirmed At #{unconfirmed_user.reload.confirmed_at.to_s(:short)}"
      )
      expect(page).not_to have_button 'Confirm'
    end
  end
end
