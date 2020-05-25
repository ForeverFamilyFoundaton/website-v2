RSpec.feature 'As a registered User', type: :feature do
  let(:succeeding_cc) { 4242424242424242 }
  let(:authentication_required_cc) { 4000002500003155 }
  let(:insuficient_funds_cc) { 4000008260003178 }
  let(:user) { users(:homer) }

  before do
    login_as user, scope: :user
    visit user_path(user)
  end

  scenario 'I can upgrade to a paid membership', :chrome, :network do
    click_on 'Upgrade to a paid membership'
    using_wait_time 10 do
      fill_stripe_elements card: succeeding_cc
      fill_in 'Full name', with: user.full_name
      click_on 'Subscribe'
      expect(page).to have_content 'Thanks for subscribing!'
      expect(user.subscribed?).to be true
    end
    click_on 'Subscription details'
    user.reload
    expect(page).to have_content user.subscription.plan.name
    expect(page).to have_content user.card_brand
    expect(page).to have_content user.card_last4
    expect(page).to have_content user.card_exp_month
    expect(page).to have_content user.card_exp_year
  end

  context 'with a card requiring authentication' do
    scenario 'I can successfully authenticate', :chrome, :network do
      click_on 'Upgrade to a paid membership'
      using_wait_time 10 do
        fill_stripe_elements card: authentication_required_cc
        fill_in 'Full name', with: user.full_name
        click_on 'Subscribe'
        expect(page).to have_text 'Confirm your $25.00 payment'
        complete_stripe_sca
        expect(page).to have_text 'Thanks for your payment'
      end
    end

    scenario 'I can fail authentication', :chrome, :network do
      click_on 'Upgrade to a paid membership'
      using_wait_time 10 do
        fill_stripe_elements card: authentication_required_cc
        fill_in 'Full name', with: user.full_name
        click_on 'Subscribe'
        expect(page).to have_text 'Confirm your $25.00 payment'
        fail_stripe_sca
        expect(page).to have_text 'We are unable to authenticate your payment method. Please choose a different payment method and try again.'
      end
    end
  end
end
