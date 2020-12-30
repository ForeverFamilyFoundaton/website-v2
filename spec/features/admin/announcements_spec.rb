RSpec.feature 'As an Admin' do
  let(:user) { users(:admin) }
  let(:announcement) { announcements(:free_beer) }
  let(:new_start_date) { 2.days.from_now.to_date }
  let(:new_end_date) { 2.weeks.from_now.to_date }
  let(:existing_end_date) { announcement.end_date }

  before do
    login_as user
    visit admin_dashboard_path
  end

  scenario 'I can manage announcements' do
    within '.header' do
      click_on 'Announcements'
    end
    click_on 'New Announcement'
    fill_in 'Body', with: 'Test Body 1'
    fill_in 'announcement_link', with: 'http://test_site.com'
    fill_in 'announcement_button', with: 'Click here'
    fill_in 'Start date', with: I18n.l(new_start_date, format: :active_admin)
    fill_in 'End date', with: I18n.l(new_end_date, format: :active_admin)
    click_on 'Create Announcement'
    expect(page).to have_content('Announcement was successfully created')
  end


  scenario 'creating an Announcement with overlapping dates fails' do
    within '.header' do
      click_on 'Announcements'
    end
    click_on 'New Announcement'
    fill_in 'Body', with: 'Test Body 1'
    fill_in 'announcement_link', with: 'http://test_site.com'
    fill_in 'announcement_button', with: 'Click here'
    fill_in 'Start date', with: I18n.l(announcement.start_date, format: :active_admin)
    fill_in 'End date', with: I18n.l(announcement.end_date, format: :active_admin)
    click_on 'Create Announcement'
    expect(page).to have_content('Announcement Conflicts with other Announcements')
  end
end
