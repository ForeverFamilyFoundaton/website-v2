RSpec.describe RecommendedBookCategory do
  it { should have_many(:recommended_book_groups) }
  it { should have_many(:recommended_books).through(:recommended_book_groups) }

  it { should validate_presence_of :name }
end
