RSpec.feature 'As an admin user' do
  let(:user) { users(:admin) }
  let(:title) { Faker::Lorem.sentence }
  let(:start_time) { 2.days.from_now }
  let(:end_time) { 5.days.from_now }

  before do
    login_as user
  end

  scenario 'I can manage Events' do
    visit admin_events_path
    click_on 'New Event'
    fill_in 'Title', with: title
    select start_time.year, from: 'event[start_time(1i)]'
    select start_time.strftime("%B"), from: 'event[start_time(2i)]'
    select start_time.day, from: 'event[start_time(3i)]'
    select start_time.hour, from: 'event[start_time(4i)]'
    select end_time.year, from: 'event[end_time(1i)]'
    select end_time.strftime("%B"), from: 'event[end_time(2i)]'
    select end_time.day, from: 'event[end_time(3i)]'
    select end_time.hour, from: 'event[end_time(4i)]'
    click_on 'Create Event'
    expect(page).to have_content 'Event was successfully created.'
    visit admin_events_path
    within first('#index_table_events tbody tr') do
      click_on 'Edit'
    end
    click_on 'Update Event'
    expect(page).to have_content 'Event was successfully updated.'
  end
end
