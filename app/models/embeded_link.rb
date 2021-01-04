class EmbededLink < ApplicationRecord
  belongs_to :em_linkable, polymorphic: true
end
