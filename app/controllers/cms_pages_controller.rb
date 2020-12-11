class CmsPagesController < ApplicationController
  def show
    @cms_page = CmsPage.friendly.find params[:id]

    case @cms_page.slug
    when /recommended-books/
      @q = RecommendedBook.ransack params[:q]
    when /radio-archives/
      @q = RadioArchive.ransack params[:q]
    end

    if @q
      @collection = @q.result(distinct: true).page(params[:page] || 1).order('title asc')
    end
  end
end
