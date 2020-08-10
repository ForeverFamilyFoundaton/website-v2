class ExternalLink < ApplicationRecord
  # belongs_to :attachable, polymorphic: true

  validates :url, presence: true, format: { with: URI::regexp(%w(http https)) }
  validates :text, presence: true
end
