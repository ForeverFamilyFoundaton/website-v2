RSpec.feature 'As a guest' do
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password }
  let(:address) { Faker::Address.street_address }
  let(:city) { Faker::Address.city }
  let(:state) { Faker::Address.state }
  let(:zip_code) { Faker::Address.zip_code }
  let(:country) { Faker::Address.country }

  before do
    clear_emails
    visit new_user_registration_path
  end

  scenario 'I can register as a user' do
    # Errors
    click_on 'Sign up'
    expect(page).to have_content "First name can't be blank"
    expect(page).to have_content "Last name can't be blank"
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
    expect(page).to have_content "Address can't be blank"
    expect(page).to have_content "City can't be blank"
    expect(page).to have_content "State can't be blank"
    expect(page).to have_content "Zip can't be blank"
    expect(page).to have_content 'Refund policy must be accepted'
    expect(page).to have_content 'Email policy must be accepted'
    expect(page).to have_content 'Volunteer policy must be accepted'
    expect(page).to have_content 'Terms of use must be accepted'

    # Valid
    fill_in 'First name', with: first_name
    fill_in 'Last name', with: last_name
    fill_in 'Address', with: address
    fill_in 'City', with: city
    fill_in 'State', with: state
    fill_in 'Zip', with: zip_code
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    check 'user_email_policy'
    check 'user_refund_policy'
    check 'user_volunteer_policy'
    check 'user_terms_of_use'
    click_on 'Sign up'

    # Confirmation
    expect(page).to have_content I18n.t 'devise.registrations.signed_up_but_unconfirmed'
    open_email email
    current_email.click_link 'Confirm my account'
    expect(page).to have_content I18n.t 'devise.confirmations.confirmed'

    # Login
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Log in'
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    expect(page).to have_content email
    expect(page).to have_content first_name
    expect(page).to have_content last_name
    expect(page).to have_content address
    expect(page).to have_content city
    expect(page).to have_content state
    expect(page).to have_content zip_code
  end
end
