class CmsPagesController < ApplicationController
  def show
    @cms_page = CmsPage.friendly.find params[:id]
    page = params[:page] || 1
    querry_params = params[:q] || {}
    case @cms_page.slug
    when /recommended-books/
      @q = RecommendedBookCategory.ransack params[:q]
    when /radio-archives/
      @q = RadioArchive.ransack params[:q]
    when /upcoming-events/
      future_params = querry_params.merge start_time_gteq: Date.today
      past_params = querry_params.merge start_time_lt: Date.today
      @q = Event.ransack future_params
      @past_events = Event.ransack(past_params).result(distinct: true).page(page)
    end

    if @q
      @collection = @q.result(distinct: true).page(page)
    end
  end
end
