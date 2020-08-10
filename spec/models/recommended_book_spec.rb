RSpec.describe RecommendedBook do
  let(:valid_params) do
    {title: 'A Title', author: 'John Doe', amazon_link: 'http://google.com'}
  end

  it { should have_many(:recommended_book_groups) }
  it { should have_many(:recommended_book_categories).through(:recommended_book_groups) }

  it { should validate_presence_of :title }
end
