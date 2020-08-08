RSpec.feature 'As an Admin' do
  let(:user) { users(:admin) }
  let(:text) { Faker::Lorem.sentence }
  let(:text_edit) { Faker::Lorem.sentence }
  let(:url) { Faker::Internet.url }

  before do
    login_as user
    visit admin_dashboard_path
  end

  scenario 'I can manage ExternalLinks' do
    within '.header' do
      click_on 'External Links'
    end
    click_on 'New External Link'
    fill_in 'Text', with: text
    fill_in 'Url', with: url
    click_on 'Create External link'
    expect(page).to have_content 'External link was successfully created.'
    visit admin_external_links_path
    expect(page).to have_content text
    click_on 'Edit'
    fill_in 'Text', with: text_edit
    click_on 'Update External link'

  end
end
