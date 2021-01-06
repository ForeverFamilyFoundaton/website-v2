module EventsHelper
  def event_times(event)
    if event.start_time.day == event.end_time.day
      [
        I18n.l(event.start_time, format: :event_date),
        [
          I18n.l(event.start_time, format: :event_time),
          I18n.l(event.end_time, format: :event_time)
        ].join(' to ')
      ].join(' ')
    else
      [start_time.to_s(:events), end_time.to_s(:events)].join(' to ')
    end
  end
end
