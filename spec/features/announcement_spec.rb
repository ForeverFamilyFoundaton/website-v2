RSpec.feature 'As a User' do
  let(:announcement) { announcements(:free_beer) }

  scenario 'I can see and hide announcements', :js do
    visit '/'
    expect(page).to have_content announcement.body
    expect(page).to have_content announcement.button
    within '#announcement' do
      find('a.close').click
    end
    expect(page).not_to have_content announcement.body
    visit '/'
    expect(page).not_to have_content announcement.body
  end
end
