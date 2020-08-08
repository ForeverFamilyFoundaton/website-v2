RSpec.feature 'As an AdminUser' do
  let(:user) { admin_users(:mr_burns) }
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password }

  before do
    login_as user, as: :admin_user
    visit admin_dashboard_path
  end

  scenario 'I can manage other AdminUsers' do
    click_on 'Admin Users'
    click_on 'New Admin User'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password Confirmation', with: password
    click_on 'Create Admin user'
    expect(page).to have_content 'AdminUser successfully created'
    expect(page).to have_content email
  end
end
