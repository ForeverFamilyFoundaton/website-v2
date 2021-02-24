class Event < ApplicationRecord
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :title
end
