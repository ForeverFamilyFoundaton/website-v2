RSpec.describe Sitterform do
  let(:user) { users(:homer) }
  let(:belief_type) { belief_types(:non_believer) }
  let(:instance) { described_class.new(params) }
  let(:params) do
    {
      user: user,
      belief_type: belief_type,
      signature: signature,
      signature_checkbox: signature_checkbox
    }
  end
  let(:signature) { Faker::Name.name }
  let(:signature_checkbox) { '1' }

  it { is_expected.to have_many :known_deads }
  it { is_expected.to have_many :relationships }

  describe '#valid?' do
    context 'with a signature but no checkbox' do
      let(:signature_checkbox) { 0 }

      it 'returns false' do
        expect(instance.valid?).to eq false
      end
    end

    context 'with a checkbox but no signature' do
      let(:signature) { '' }

      it 'returns false' do
        expect(instance.valid?).to eq false
      end
    end

    context 'with a checkbox and a signature' do
      it 'returns true' do
        expect(instance.valid?).to eq true
      end
    end

    context 'with no signature and no checkbox' do
      let(:signature_checkbox) { '0' }
      let(:signature) { '' }

      it 'returns true' do
        expect(instance.valid?).to eq true
      end
    end
  end

end
