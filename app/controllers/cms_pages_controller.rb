class CmsPagesController < ApplicationController
  def show
    @cms_page = CmsPage.friendly.find params[:id]
    page = params[:page] || 1
    querry_params = params[:q] || {}
    case @cms_page.slug
    when /recommended-books/
      @q = RecommendedBookCategory.ransack params[:q]
      @collection = @q.result(distinct: true).page(page)
    when /radio-archives/
      radio_show_params = (params[:q] || {}).merge date_lteq: Time.now
      @q = RadioShow.ransack radio_show_params
      @collection = @q.result(distinct: true).includes(:embeded_links, :attached_file).order(date: :desc).page(page)
    when /broadcast-schedule/
      radio_show_params = (params[:q] || {}).merge date_gteq: Time.now
      @q = RadioShow.ransack radio_show_params
      @collection = @q.result(distinct: true).includes(:embeded_links, :attached_file).order(date: :desc).page(page)
    when /upcoming-events/
      event_params = querry_params.merge start_time_gteq: Date.today
      @q = Event.ransack event_params
      @collection = @q.result(distinct: true).order(start_time: :desc).page(page)
    end
  end
end
