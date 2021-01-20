RSpec.feature 'As a user' do
  let(:radio_archive) { radio_shows(:archive_1) }
  let(:cms_page) { CmsPage.find_by reference_string: :radio_archives }

  before do
    visit page_path(cms_page)
  end

  scenario 'I can view the Radio Archives' do
    expect(page).to have_selector '.radio-show', count: 2
  end

  scenario 'I can search for radio archives' do
    fill_in 'q[title_or_guest_cont]', with: radio_archive.title
    click_on 'Search'
    expect(page).to have_selector '.radio-show', count: 1
  end
end
