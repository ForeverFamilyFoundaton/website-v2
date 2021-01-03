class Event < ApplicationRecord
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :title

  scope :upcoming, -> { where("end_time >= ?", Time.zone.now).order('start_time asc').limit(6) }
  scope :all_upcoming, -> { where("end_time >= ?", Time.zone.now).order('start_time asc') }

  def times
    if start_time.day == end_time.day
      "#{start_time.to_s(:ordinal_date)} " + [start_time.strftime("%l:%M %p"), end_time.strftime("%l:%M %p")].join(' - ')
    else
      [start_time.to_s(:events), end_time.to_s(:events)].join(' to ')
    end
  end

  def teaser
    truncate strip_tags(description)
  end
end
