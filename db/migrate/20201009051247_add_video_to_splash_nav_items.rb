class AddVideoToSplashNavItems < ActiveRecord::Migration[6.0]
  def change
    add_column :splash_nav_items, :video_url, :string
  end
end
