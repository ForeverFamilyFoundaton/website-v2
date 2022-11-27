RSpec.feature 'As an Admin' do
  let(:user) { users(:admin) }
  let(:title) { Faker::Lorem.sentence }
  let(:new_title) { Faker::Lorem.sentence }
  let(:body) { Faker::Lorem.paragraph }
  let(:item_1) { splash_nav_items(:one) }
  let(:item_2) { splash_nav_items(:two) }
  let(:item_3) { splash_nav_items(:three) }

  before do
    login_as user
    visit admin_dashboard_path
    click_on 'Splash Nav Items'
  end

  scenario 'I can manage SplashNavItems', :js do
    click_on 'New Splash Nav Item'
    fill_in 'Title', with: title
    fill_in 'Body', with: body
    js_select item_1.title, from: 'Cms page'
    attach_file 'Image', Rails.root.join('spec/fixtures/img/test.jpg')
    click_on 'Create Splash nav item'
    expect(page).to have_content 'Splash nav item was successfully created'
    expect(page).to have_content title
    expect(page).to have_content body
    click_on 'Edit Splash Nav Item'
    fill_in 'Title', with: new_title
    click_on 'Update Splash nav item'
    expect(page).to have_content 'Splash nav item was successfully updated.'
    expect(page).to have_content new_title
  end

  scenario 'I can sort SplashNavitems', :js do
    visit admin_splash_nav_items_path
    within 'tr.splash-nav-item:nth-child(1)' do
      expect(page).to have_content item_1.title
    end
    within 'tr.splash-nav-item:nth-child(2)' do
      expect(page).to have_content item_2.title
    end
    within 'tr.splash-nav-item:nth-child(3)' do
      expect(page).to have_content item_3.title
    end
    source = page.find("#splash_nav_item_#{item_3.id}").find('.drag-handle')
    target = page.find("#splash_nav_item_#{item_1.id}")
    source.drag_to target
    visit admin_splash_nav_items_path
    within 'tr.splash-nav-item:nth-child(2)' do
      expect(page).to have_content item_3.title
    end
  end
end
