class AddNavItemToCmsPages < ActiveRecord::Migration[6.0]
  def change
    add_column :cms_pages, :nav_item, :boolean
  end
end
