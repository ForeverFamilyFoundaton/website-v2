class RadioShow < ApplicationRecord
  has_many :embeded_links, as: :em_linkable, dependent: :destroy
  accepts_nested_attributes_for :embeded_links, allow_destroy: true

  has_one :attached_file, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attached_file, allow_destroy: true

  validates :title, presence: true

  default_scope { order(date: :desc) }
end
