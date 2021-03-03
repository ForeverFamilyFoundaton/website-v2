RSpec.feature 'As a user' do
  include_context 'User Profile Data'
  include_context 'Social Media Data'
  let(:admin_user) { users(:admin) }

  let(:user) { users(:homer) }
  let(:other_activities_1) { Faker::Lorem.paragraph }
  let(:other_activities_2) { Faker::Lorem.paragraph }
  let(:other_activities_3) { Faker::Lorem.paragraph }
  let(:intuitive_information_1) { Faker::Lorem.paragraph }
  let(:intuitive_information_2) { Faker::Lorem.paragraph }
  let(:intuitive_information_3) { Faker::Lorem.paragraph }
  let(:intuitive_information_4) { Faker::Lorem.paragraph }
  let(:intuitive_information_5) { Faker::Lorem.paragraph }
  let(:intuitive_information_6) { Faker::Lorem.paragraph }
  let(:professional_information_1) { Faker::Lorem.paragraph }
  let(:professional_information_2) { Faker::Lorem.paragraph }
  let(:professional_information_selection_1) { MediumformPreference.practice_preferences.sample }
  let(:professional_information_selection_2) { MediumformPreference.selfclassify_preferences.sample }
  let(:professional_information_3) { Faker::Lorem.paragraph }
  let(:professional_information_4) { Faker::Lorem.paragraph }
  let(:ethics_questionaire_1) { Faker::Lorem.paragraph }
  let(:ethics_questionaire_2) { Faker::Lorem.paragraph }
  let(:ethics_questionaire_3) { Faker::Lorem.paragraph }
  let(:ethics_questionaire_4) { Faker::Lorem.paragraph }
  let(:signature) { Faker::Name.full_name }

  context 'when not logged in' do
    scenario 'registration redirects to sign in' do
      visit new_mediumform_path
      expect(page).to have_content I18n.t('devise.failure.unauthenticated')
    end
  end

  context 'when logged in' do
    before do
      clear_emails
      user.update! medium_registration: true
      login_as user
    end

    context 'with no Medium Registration Flag' do
      before do
        user.update! medium_registration: false
      end

      scenario 'I do not see the Sitter Registration options' do
        visit user_path(user)
        expect(page).to_not have_content 'Medium Registration'
      end
    end

    let(:cms_page) { CmsPage.find_by(reference_string: :medium_registration) }

    scenario 'I can register to be a Medium', :js do
      visit new_mediumform_path
      expect(page).to have_content cms_page.title
      within '.profile-details' do
        expect(page).to have_content user.first_name
        expect(page).to have_content user.middle_name
        expect(page).to have_content user.last_name
        expect(page).to have_content user.cell_phone
        expect(page).to have_content user.home_phone
        expect(page).to have_content user.work_phone
        expect(page).to have_content user.address[:street]
        expect(page).to have_content user.address[:city]
        expect(page).to have_content user.address[:state]
        expect(page).to have_content user.address[:zip]
      end
      within '.alternate-profile-details' do
        fill_in 'First name', with: first_name
        fill_in 'Middle name', with: middle_name
        fill_in 'Last name', with: last_name
        fill_in 'Cell phone', with: cell_phone
        fill_in 'Home phone', with: home_phone
        fill_in 'Work phone', with: work_phone
        fill_in 'Home email', with: home_email
        fill_in 'Work email', with: work_email
        fill_in 'Street address', with:  street_address_1
        fill_in 'Street address (line 2)', with:  street_address_2
        fill_in 'City', with:  city
        fill_in 'State', with:  state
        fill_in 'Zipcode', with:  zip
      end

      within '.social-media' do
        fill_in 'Website', with: website
        fill_in 'Facebook', with: facebook
        fill_in 'Pinterest', with: pinterest
        fill_in 'Instagram', with: instagram
        fill_in 'Twitter', with: twitter
        fill_in 'Youtube', with: youtube
        fill_in 'Blog', with: blog
      end
      fill_in 'Electronic Signature', with: user.full_name
      check I18n.t('medium_registration.labels.terms')

      click_on 'Save'

      expect(page).to have_content I18n.t('medium_registration.success')

      within '.medium-registration' do
        expect(page).to have_content 'Continue Registration'
      end

      open_email Rails.application.credentials.new_registration_notification_email
      expect(current_email.subject).to eq 'New Medium Registration'
      login_as admin_user
      current_email.click_link user.full_name
      expect(page).to have_content user.full_name
    end
  end
end
