RSpec.feature 'As a registered User' do
  let(:user) { users(:marge) }
  let(:family_member_attributes) do
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
    }
  end

  before do
    login_as user
  end

  scenario 'I can edit my family members', :chrome do
    visit user_path(user)
    within '.family-members' do
      click_on 'Click here'
    end
    fill_in 'First name', with: family_member_attributes[:first_name]
    fill_in 'Last name', with: family_member_attributes[:last_name]
    fill_in 'Email', with: family_member_attributes[:email]
    select 'Spouse / Significant other'
    click_on 'Create Family Member'
    expect(page).to have_content 'Family member successfully created!'
    expect(page).to have_content family_member_attributes[:first_name]
    expect(page).to have_content family_member_attributes[:last_name]
    expect(page).to have_content family_member_attributes[:email]
    expect(page).to have_selected_value 'Spouse / Significant other'

    within '.family-member:first' do
      find('a.edit').click
    end
    fill_in 'First name', with: new_name
    click_on 'Submit'
    expect(page).to have_content new_name

    within '.family-member:first' do
      find('a.delete').click
    end
    expect(page).to have_content 'Family Member successfully deleted.'
    expect(page).not_to have_content new_name
  end

  scenario 'I cannot edit confirmed Family Members' do
    within "#family-member-#{family_member.id}" do
      expect(page).not_to have_selector 'a.edit'
      expect(page).not_to have_selector 'a.delete'
    end
  end
end
