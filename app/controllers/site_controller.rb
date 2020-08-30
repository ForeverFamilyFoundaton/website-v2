class SiteController < ApplicationController
  layout 'splash', only: :index

  def index
    @splash_nav_items = SplashNavItem.rank(:row_order).all
  end
  def page; end
  def after_life_discussion_group; end
  def after_life_science; end
  def radio_archives; end
  def business_membership; end
  def certified_mediums; end
  def contact; end
  def contributions; end
  def conciousness_blogs; end
  def grief_and_loss; end
  def logged_in_index; end
  def signs_of_life_newsletter; end
  def signs_of_life_radio; end
  def store; end
  def recc_book_categories; end
  def support_and_information; end
  def volunteers; end
  def terms; end
  def privacy; end

private
  def get_events
    @events = Event.upcoming
  end
end
