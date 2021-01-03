class SiteController < ApplicationController
  layout 'splash', only: :index

  def index
    @splash_nav_items = SplashNavItem.rank(:row_order).all
  end
end
