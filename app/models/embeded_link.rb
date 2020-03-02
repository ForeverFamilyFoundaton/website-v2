class EmbededLink < ApplicationRecord
  # attr_accessible :body, :title
  belongs_to :em_linkable, polymorphic: true
end
