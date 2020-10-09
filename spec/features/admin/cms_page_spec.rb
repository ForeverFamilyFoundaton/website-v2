RSpec.feature 'As an Admin User' do
  let(:user) { users(:admin) }
  let(:reference_string) { Faker::Lorem.sentence }
  let(:title) { Faker::Lorem.sentence }
  let!(:existing_page) { create(:cms_page) }

  before do
    login_as user
    visit admin_cms_pages_path
  end

  scenario 'I can assign a parent to a CmsPage' do
    click_on 'New Cms Page'
    fill_in 'Reference string', with: reference_string
    fill_in 'Title', with: title
    select existing_page.reference_string
    click_on 'Create Cms page'
    expect(page).to have_content 'Cms page was successfully created.'
    expect(page).to have_content title
    expect(page).to have_content existing_page.reference_string
  end
end
