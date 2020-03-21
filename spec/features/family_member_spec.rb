RSpec.feature 'As a registered User' do
  let(:user) { users(:marge) }
  let(:family_member_attributes) do
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: Faker::Internet.password
    }
  end

  before do
    clear_emails
    user.family_members.destroy_all
    login_as user
  end

  scenario 'I can invite a family member' do
    visit user_path(user)
    within '.family-members' do
      click_on 'Click here'
    end
    fill_in 'First name', with: family_member_attributes[:first_name]
    fill_in 'Last name', with: family_member_attributes[:last_name]
    fill_in 'Email', with: family_member_attributes[:email]
    select 'Spouse / Significant other'
    click_on 'Create Family Member'
    expect(page).to have_content I18n.t 'family_member_invitations.create.success'
    expect(page).to have_content family_member_attributes[:first_name]
    expect(page).to have_content family_member_attributes[:last_name]
    expect(page).to have_content family_member_attributes[:email]
    expect(page).to have_content 'Spouse / Significant other'
    expect(page).to have_content 'Invited'

    click_on 'Sign out'

    open_email family_member_attributes[:email]
    current_email.click_link 'Accept invitation'
    expect(page).to have_content I18n.t 'devise.invitations.edit.header'
    fill_in 'Password', with: family_member_attributes[:password]
    fill_in 'Password confirmation', with: family_member_attributes[:password]
    click_on I18n.t('devise.invitations.edit.submit_button')
    expect(page).to have_content I18n.t('devise.invitations.updated')
  end

  scenario 'I can edit my family members', :chrome do
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
