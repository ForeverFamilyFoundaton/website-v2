class AddTeaserToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :teaser, :text
  end
end
