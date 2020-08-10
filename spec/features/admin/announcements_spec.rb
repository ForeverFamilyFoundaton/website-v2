RSpec.feature 'As an Admin' do
  let(:user) { users(:admin) }
  let(:announcement) { announcements(:free_beer) }

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
    select '2016', from: 'announcement[start_date(1i)]'
    select 'January', from: 'announcement[start_date(2i)]'
    select '1', from: 'announcement[start_date(3i)]'
    select '2016', from: 'announcement[end_date(1i)]'
    select 'January', from: 'announcement[end_date(2i)]'
    select '20', from: 'announcement[end_date(3i)]'
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
    select announcement.start_date.strftime("%Y"), from: 'announcement[start_date(1i)]'
    select announcement.start_date.strftime("%B"), from: 'announcement[start_date(2i)]'
    select announcement.start_date.strftime("%-d"), from: 'announcement[start_date(3i)]'
    select announcement.end_date.strftime("%Y"), from: 'announcement[end_date(1i)]'
    select announcement.end_date.strftime("%B"), from: 'announcement[end_date(2i)]'
    select announcement.end_date.strftime("%-d"), from: 'announcement[end_date(3i)]'
    click_on 'Create Announcement'
    expect(page).to have_content('Announcement Conflicts with other Announcements')
  end
end
