class RadioArchive < ApplicationRecord
  paginates_per 10

  has_many :embeded_links, as: :em_linkable, dependent: :destroy
  accepts_nested_attributes_for :embeded_links

  has_one :attached_file, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attached_file

  validates :title, presence: true
end
