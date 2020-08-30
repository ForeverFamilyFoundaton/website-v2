RSpec.describe SplashNavItem do
  let(:resource) { described_class.new(params) }
  let(:params) do
    {
      title: title,
      body: body,
      link: link
    }
  end
  let(:title) { Faker::Lorem.sentence }
  let(:body) { Faker::Lorem.paragraph }
  let(:link) { Faker::Internet.url }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }
end
