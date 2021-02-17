RSpec.feature 'As an Admin User' do
  let(:user) { users(:admin) }
  let(:title) { Faker::Lorem.sentence }
  let!(:caption) { Faker::Lorem.sentence }

  before do
    login_as user
    visit admin_cms_images_path
  end

  scenario 'I can assign a parent to a CmsPage' do
    click_on 'New Cms Image'
    fill_in 'Title', with: title
    attach_file 'Image', Rails.root.join('spec/fixtures/img/test.jpg')
    fill_in 'Caption', with: caption
    click_on 'Create Cms image'
    expect(page).to have_content 'Cms image was successfully created.'
    expect(page).to have_content title
    expect(page).to have_content caption
  end
end
