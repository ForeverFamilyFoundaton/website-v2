RSpec.feature 'As a user' do
  let(:user) { users(:homer) }
  let(:first_name) { Faker::Name.first_name }
  let(:middle_name) { Faker::Name.middle_name }
  let(:last_name) { Faker::Name.last_name }
  let(:cell_phone) { Faker::PhoneNumber.cell_phone }
  let(:home_phone) { Faker::PhoneNumber.phone_number }
  let(:work_phone) { Faker::PhoneNumber.cell_phone }
  let(:home_email) { Faker::Internet.email }
  let(:work_email) { Faker::Internet.email }
  let(:street_address_1) { Faker::Address.street_address }
  let(:street_address_2) { Faker::Address.building_number }
  let(:city) { Faker::Address.city }
  let(:state) { Faker::Address.state }
  let(:zip) { Faker::Address.zip }
  let(:country) { Faker::Address.country }
  let(:website) { Faker::Internet.website }
  let(:website) { Faker::Internet.website }
  let(:facebooks) { Faker::Internet.facebooks }
  let(:pinterest) { Faker::Internet.pinterest }
  let(:instagram) { Faker::Internet.instagram }
  let(:twitter) { Faker::Internet.twitter }
  let(:youtube) { Faker::Internet.youtube }
  let(:blog) { Faker::Internet.blog }
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
      login_as user
    end

    scenario 'I can register to be a Medium' do
      visit new_mediumform_path
      expect(page).to have_content 'Mediumforms: New'
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
    end
  end
end
