class CmsImage < ApplicationRecord
  paperclip_opts = { styles: { thumb: '100x100>' } }

  paperclip_opts.merge!({ bucket: Rails.application.credentials.aws[:bucket] })

  has_attached_file :attachment, paperclip_opts

  has_attached_file :image, paperclip_opts
  do_not_validate_attachment_file_type :image
end
