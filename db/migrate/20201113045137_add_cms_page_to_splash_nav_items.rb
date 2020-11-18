class AddCmsPageToSplashNavItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :splash_nav_items, :link, :string
    remove_column :splash_nav_items, :video_url, :string
    add_reference :splash_nav_items, :cms_page
  end
end
