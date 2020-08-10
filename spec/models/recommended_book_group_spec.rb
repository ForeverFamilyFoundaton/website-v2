RSpec.describe RecommendedBookGroup do

  it { should belong_to(:recommended_book) }
  it { should belong_to(:recommended_book_category) }

end
