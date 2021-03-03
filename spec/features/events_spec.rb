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

  context 'with comments in the #teaser' do
    let(:comment_text) { Faker::Lorem.sentence }

    before do
      event.update! teaser: "Here is some text\n\n<!-- #{comment_text} -->"
    end

    scenario 'I should not see comments' do
      visit current_path
      expect(page).not_to have_content comment_text
    end
  end
end
