RSpec.describe User, type: :model do
  let(:user) { users(:homer) }

  describe '#update_card', :vcr do
    before do
      user.update_card('pm_card_visa')
    end

    it 'sets #card_brand' do
      expect(user.card_brand).to eq 'Visa'
    end

    it 'sets #card_last4' do
      expect(user.card_last4).to eq '4242'
    end
  end

  describe '#subscribe', :vcr do
    let(:plan) { plans(:yearly_membership) }

    before do
      user.update_card("pm_card_visa")
    end

    context 'with a valid card' do
      it 'creates a subscription' do
        expect {
          user.subscribe(plan.stripe_id)
        }.to change(Subscription, :count).by 1
      end

      it 'subscribes the user' do
        user.subscribe plan.stripe_id
        expect(user.subscribed?).to be true
      end
    end

    context 'with a card requiring authentication' do
      before do
        user.update_card('pm_card_authenticationRequired')
      end

      it 'raises an exception' do
        expect {
          user.subscribe(plan.stripe_id)
        }.to raise_error PaymentIncomplete
        expect(Subscription.last.status).to eq 'incomplete'
      end
    end
  end
end
