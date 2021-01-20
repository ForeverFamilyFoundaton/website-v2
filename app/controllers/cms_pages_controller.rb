class CmsPagesController < ApplicationController
  def show
    @cms_page = CmsPage.friendly.find params[:id]
    page = params[:page] || 1
    querry_params = params[:q] || {}

    @collection = case @cms_page.slug
    when /recommended-books/
      @search_field = :recommended_books_title_cont
      @q = RecommendedBookCategory.ransack params[:q]
      @q.result(distinct: true).page(page)
    when /radio-archives/
      @search_field = :title_or_guest_cont
      radio_show_params = (params[:q] || {}).merge date_lteq: Time.now
      @q = RadioShow.ransack radio_show_params
      @q.result(distinct: true).includes(:embeded_links, :attached_file).order(date: :desc).page(page)
    when /broadcast-schedule/
      @search_field = :title_or_guest_cont
      radio_show_params = (params[:q] || {}).merge date_gteq: Time.now
      @q = RadioShow.ransack radio_show_params
      @q.result(distinct: true).
        includes(:embeded_links, :attached_file).
        order(date: :asc).page(page)
    when /upcoming-events/
      @search_field = :title_cont
      event_params = querry_params.merge start_time_gteq: Date.today
      @q = Event.ransack event_params
      @q.result(distinct: true).order(start_time: :desc).page(page)
    end
  end
end
