RSpec.feature 'As an admin user' do
  let(:user) { users(:admin) }
  let(:title) { Faker::Lorem.sentence }
  let(:instructions) { Faker::Lorem.paragraph }
  let(:format) { 'Signs of Life'}
  let(:guest) { Faker::Name.first_name }
  let(:date) { 5.days.from_now.to_date }

  before do
    login_as user
  end

  scenario 'I can manage Events' do
    visit admin_radio_shows_path
    click_on 'New Radio Show'
    fill_in 'Title', with: title
    fill_in 'Guest', with: guest
    fill_in 'Date', with: I18n.l(date, format: :active_admin)
    fill_in 'Instructions', with: instructions
    select format
    click_on 'Create Radio show'
    expect(page).to have_content 'Radio show was successfully created.'
    expect(page).to have_content title
    expect(page).to have_content instructions
    expect(page).to have_content guest

    visit admin_radio_shows_path
    within first('#index_table_radio_shows tbody tr') do
      click_on 'Edit'
    end
    click_on 'Update Radio show'
    expect(page).to have_content 'Radio show was successfully updated.'
  end
end
