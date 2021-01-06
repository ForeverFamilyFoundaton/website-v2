class SiteController < ApplicationController
  layout 'splash', only: :index

  def index
    @splash_nav_items = SplashNavItem.rank(:row_order).all
  end

  def page
    @cms_page = CmsPage.find params[:id]
    render 'cms_pages/show'
  end
end
