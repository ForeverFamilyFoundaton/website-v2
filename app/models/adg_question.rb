class AdgQuestion < ApplicationRecord
  validates_presence_of :question

  # attr_accessible :question, :show_radio
end
