RSpec.describe Subscription, type: :model do
  let(:user) { users(:homer) }
  let(:plan) { plans(:yearly_membership) }
  let(:subscription) { user.subscribe plan.stripe_id }

  before do
    Timecop.return
    user.update_card 'pm_card_visa'
  end

  after do
    # From test.rb
    t = Time.local(2018, 10, 2, 11, 5, 0)
    Timecop.travel(t)
  end

  describe '#cancel', :vcr do
    before do
      subscription.cancel
    end

    it 'sets #canceled?' do
      expect(subscription.canceled?).to be true
    end

    it 'sets #on_grace_period?' do
      expect(subscription.on_grace_period?).to be true
    end
  end

  describe '#cancel_now!', :vcr do
    before do
      subscription.cancel_now!
    end

    it 'sets #canceled?' do
      expect(subscription.canceled?).to be true
    end

    it 'sets #on_grace_period?' do
      expect(subscription.on_grace_period?).to be false
    end
  end

  describe '#resume', :vcr do
    before do
      subscription.cancel
      subscription.resume
    end

    it 'sets #canceled?' do
      expect(subscription.canceled?).to be false
    end

    it 'sets #active?' do
      expect(subscription.active?).to be true
    end

    context 'outside the grace period' do
      before do
        subscription.cancel_now!
      end

      it 'raises if outside the grace period' do
        expect {
          subscription.resume
        }.to raise_error StandardError
      end
    end
  end
end
