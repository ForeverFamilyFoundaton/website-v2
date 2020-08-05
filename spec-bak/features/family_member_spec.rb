RSpec.feature 'As a registered User' do
  let(:user) { users(:marge) }
  let(:homer) { users(:homer) }
  let(:bart) { users(:bart) }
  let(:family_member_attributes) do
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: Faker::Internet.password
    }
  end
  let(:invite_user) do
    InviteFamilyMember.new(
      params: {
        email: family_member_attributes[:email],
        role: FamilyMemberInvitation::ROLE_OPTIONS.sample
      },
      invitor: user
    ).call
  end

  before do
    clear_emails
    login_as user
  end

  scenario 'I can invite a family member' do
    visit user_path(user)
    within '.family-members' do
      find('a.add').click
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

  context 'with a family member who is NOT confirmed' do
    let(:invited_user) { User.order(:created_at).last }

    before do
      invite_user
      visit user_path(user)
    end

    scenario 'I can delete family members who are not confirmed' do
      within "#family-member-#{invited_user.id}" do
        expect(page).to have_content 'Invited'
        expect(page).not_to have_content 'Confirmed'
        find('a.delete').click
      end
      expect(page).to have_content I18n.t('family_members.destroy.success')
      expect(page).not_to have_content family_member_attributes[:first_name]
    end
  end

  context 'with a confirmed family member' do
    let(:invited_user) { User.order(:created_at).last }

    before do
      logout :user
      invite_user
      accept_invitation(
        family_member_attributes[:email],
        family_member_attributes[:password]
      )
      logout :user
      login_as user
      visit user_path(user)
    end

    scenario 'there is no delete button' do
      within "#family-member-#{invited_user.id}" do
        expect(page).to have_content 'Confirmed'
        expect(page).not_to have_selector 'a.delete'
      end
    end
  end

  context 'as a family member who is NOT the Owner' do
    let(:user) { family_memberships(:spouse).user }

    before do
      visit user_path(user)
    end

    scenario 'I CANNOT add or delete family members' do
      within '.family-members' do
        expect(page).not_to have_selector 'a.add'
        expect(page).not_to have_selector 'a.delete'
      end
    end
  end
end
