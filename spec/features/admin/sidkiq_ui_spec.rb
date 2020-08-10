RSpec.describe 'As an admin user' do
  let!(:user) { users(:admin) }

  before do
    login_as user
  end

  scenario 'I can see the Sidekiq UI' do
    visit admin_dashboard_path
    click_on 'Jobs'
    expect(page).to have_content 'Sidekiq'
  end
end
