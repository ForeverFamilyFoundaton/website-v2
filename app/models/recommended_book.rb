class RecommendedBook < ApplicationRecord
  has_many :recommended_book_groups
  has_many :recommended_book_categories, through: :recommended_book_groups

  validates :title, presence: true
  validates :amazon_link, url: true
  validates :uk_amazon_link, url: true
  validates :cad_amazon_link, url: true
end
