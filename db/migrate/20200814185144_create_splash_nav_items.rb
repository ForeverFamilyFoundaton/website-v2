class CreateSplashNavItems < ActiveRecord::Migration[6.0]
  def change
    create_table :splash_nav_items do |t|
      t.string :title
      t.text :body
      t.text :image_data
      t.string :link
      t.integer :row_order

      t.timestamps
    end
  end
end
