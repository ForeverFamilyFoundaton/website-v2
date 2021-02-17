class CmsImage < ApplicationRecord
  paperclip_opts = { styles: { thumb: '100x100>' } }

  has_attached_file :image, paperclip_opts
  do_not_validate_attachment_file_type :image
  validates :image, presence: true
end
