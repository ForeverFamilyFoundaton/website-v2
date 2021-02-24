RSpec.feature 'As a user' do
  let(:event) { events(:one) }
  let(:cms_page) { CmsPage.find_by reference_string: :upcoming_events }

  before do
    visit page_path(cms_page)
  end

  scenario 'I can view the Events' do
    expect(page).to have_content event.title
    expect(page).to have_content 'Eastern Time'
  end
end
