class RenameRadioArchives < ActiveRecord::Migration[6.0]
  def change
    rename_table :radio_archives, :radio_shows
  end
end
