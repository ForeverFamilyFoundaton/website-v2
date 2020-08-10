RSpec.feature 'As a User' do
  include_context 'User Profile Data'
  include_context 'Social Media Data'

  let(:user) { users(:homer) }

  before do
    login_as user
    visit user_path(user)
  end

  context 'with no Sitter Registration Flag' do
    before do
      user.update! sitter_registration: false
    end

    scenario 'I do not see the Sitter Registration options' do
      expect(page).to_not have_content 'Sitter Registration'
    end
  end

  context 'with Sitter Registration Flag set to true' do
    let(:related_contact_info) { Faker::Lorem.paragraph }
    let(:medium_contacts) { Faker::Lorem.paragraph }
    let(:belief_type) { BeliefType.all.map(&:name).sample }
    let(:known_dead_first_name) { Faker::Name.first_name }
    let(:known_dead_relationship) { Relationship.all.map(&:name).sample }
    let(:known_dead_year) { (100.years.ago.year..Date.today.year).to_a.sample }

    before do
      user.update! sitter_registration: true
      visit user_path(user)
    end

    scenario 'I can fill out the Sitter Registration' do
      within '.sitter-registration' do
        click_on 'Begin Registration'
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
      fill_in I18n.t('sitter_registration.labels.related_contact_info'), with: related_contact_info
      fill_in I18n.t('sitter_registration.labels.medium_contacts'), with: medium_contacts
      choose belief_type
      within first('.known-dead') do
        fill_in 'First name', with: known_dead_first_name
        select known_dead_relationship
        fill_in 'YYYY', with: known_dead_year
      end
      click_on 'Save'
      expect(page).to have_content 'Sitterform was successfully created.'
      within '.sitter-registration' do
        click_on 'Continue Registration'
      end
      expect(page).to have_field 'Website', with: website
      expect(page).to have_field 'Facebook', with: facebook
      expect(page).to have_field 'Pinterest', with: pinterest
      expect(page).to have_field 'Instagram', with: instagram
      expect(page).to have_field 'Twitter', with: twitter
      expect(page).to have_field 'Youtube', with: youtube
      expect(page).to have_field 'Blog', with: blog

    end
  end
end
