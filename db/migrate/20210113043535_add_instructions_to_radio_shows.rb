class AddInstructionsToRadioShows < ActiveRecord::Migration[6.0]
  def change
    add_column :radio_shows, :instructions, :text
  end
end
