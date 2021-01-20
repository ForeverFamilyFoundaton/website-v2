RSpec.feature 'As a user' do
  let(:radio_show_1) { radio_shows(:radio_show_1) }
  let(:radio_show_2) { radio_shows(:radio_show_2) }
  let(:cms_page) { CmsPage.find_by reference_string: :broadcast_schedule }

  before do
    visit page_path(cms_page)
  end

  scenario 'I see closest radio shows first' do
    within first('.radio-show') do
      expect(page).to have_content radio_show_1.title
    end
    within '.radio-show:nth-of-type(2)' do
      expect(page).to have_content radio_show_2.title
    end
  end
end
