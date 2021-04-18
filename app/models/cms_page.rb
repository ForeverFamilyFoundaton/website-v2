class CmsPage < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_tree order: :position

  alias_attribute :subject, :title

  validates :reference_string, presence: true, uniqueness: true
  validates :title, presence: true

  scope :nav_items, -> { where(nav_item: true) }

  def partial_name
    slug.underscore
  end
end
