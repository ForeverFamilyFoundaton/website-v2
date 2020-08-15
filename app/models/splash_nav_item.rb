class SplashNavItem < ApplicationRecord
  include ImageUploader::Attachment :image
  include RankedModel
  ranks :row_order

  validates :title, presence: true
  validates :body, presence: true
  validates :link, presence: true, url: true
end
