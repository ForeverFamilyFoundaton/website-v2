RSpec.feature 'As a user' do
  let(:radio_archive) { radio_archives(:archive_1) }

  before do
    visit radio_archives_path
  end

  scenario 'I can view the Radio Archives' do
    expect(page).to have_selector '.radio-archive', count: 2
  end

  scenario 'I can search for radio archives' do
    fill_in 'q[title_or_guest_cont]', with: radio_archive.title
    click_on 'Search'
    expect(page).to have_selector '.radio-archive', count: 1
  end

  context 'requesting a non-existent RadioArchive' do
    before do
      visit radio_archive_path('Foo')
    end

    scenario 'I am redirected to the :index page' do
      expect(page).to have_content "Couldn't find"
      expect(page).to have_content 'Radio Archives'
    end
  end
end
