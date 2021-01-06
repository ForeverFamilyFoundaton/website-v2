class EventsController < ApplicationController
  def index
    @events = Event.all_upcoming
  end

  def show
    @event = Event.find(params[:id])
  end
end
