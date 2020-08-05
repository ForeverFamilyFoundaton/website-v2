RSpec.describe Sitterform, :sitterform, type: :model do
  let(:valid_params) do
    {title: 'A Title', author: 'John Doe', amazon_link: 'http://google.com'}
  end

  it { should have_many(:known_deads) }
  it { should have_many(:relationships) }
end
