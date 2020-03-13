RSpec.feature 'As a registered User' do
  let(:succeeding_cc) { 4242424242424242 }
  let(:authentication_required_cc) { 4000002500003155 }
  let(:insuficient_funds_cc) { 4000008260003178 }
  let(:user) { users(:homer) }

  before do
    login_as user, scope: :user
    visit user_path(user)
  end

  scenario 'I can upgrade to a paid membership', :chrome do
    click_on 'Upgrade'
    fill_stripe_elements card: succeeding_cc
    expect(page).to have_content 'Subscription Success!'
  end

  context 'with a card requiring authentication', :chrome do
    scenario 'I am prompted for authentication' do
      click_on 'Upgrade'
      fill_stripe_elements card: authentication_required_cc
      pause
      # expect(page).to have_content 'Subscription Success!'

    end
  end
end
