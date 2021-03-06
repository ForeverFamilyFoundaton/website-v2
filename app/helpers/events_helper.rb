module EventsHelper
  def event_times(event)
    if event.start_time.day == event.end_time.day
      [
        event.start_time.to_date.to_s(:long_ordinal),
        [
          I18n.l(event.start_time, format: :event_time),
          I18n.l(event.end_time, format: :event_time)
        ].join(' - ')
      ].join(' ')
    else
      [
        [
          event.start_time.to_date.to_s(:long_ordinal), I18n.l(event.start_time, format: :event_time)
        ].join(' '),
        [
          event.end_time.to_date.to_s(:long_ordinal), I18n.l(event.end_time, format: :event_time)
        ].join(' ')
      ].join(' - ')
    end
  end
end
