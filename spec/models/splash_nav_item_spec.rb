RSpec.describe SplashNavItem do
  let(:resource) { described_class.new(params) }
  let(:params) do
    {
      title: title,
      body: body,
      link: link,
      image: image_fixture
    }
  end
  let(:title) { Faker::Lorem.sentence }
  let(:body) { Faker::Lorem.paragraph }
  let(:link) { Faker::Internet.url }
  let(:image_fixture) { File.open('spec/fixtures/img/test.gif', 'rb') }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }

  context 'with a well-formed url' do
    it 'is valid' do
      expect(resource.valid?).to eq true
    end
  end

  context 'with a poorly formed url' do
    let(:link) { 'foo' }

    it 'is invalid' do
      expect(resource.valid?).to eq false
    end
  end
end
