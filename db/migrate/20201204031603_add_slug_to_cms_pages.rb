class AddSlugToCmsPages < ActiveRecord::Migration[6.0]
  def change
    add_column :cms_pages, :slug, :string
    add_index :cms_pages, :slug, unique: true
  end
end
