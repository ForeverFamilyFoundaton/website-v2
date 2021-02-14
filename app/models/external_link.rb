# Obsolete class?
class ExternalLink < ApplicationRecord
  validates :url, presence: true, format: { with: URI::regexp(%w(http https)) }
  validates :text, presence: true
end
