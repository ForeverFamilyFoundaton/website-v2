class Event < ApplicationRecord
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :title

  scope :upcoming, -> { where("end_time >= ?", Time.zone.now).order('start_time asc').limit(6) }
  scope :all_upcoming, -> { where("end_time >= ?", Time.zone.now).order('start_time asc') }

  def teaser
    truncate strip_tags(description)
  end
end
