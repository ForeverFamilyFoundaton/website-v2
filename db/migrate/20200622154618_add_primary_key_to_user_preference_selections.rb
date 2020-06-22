class AddPrimaryKeyToUserPreferenceSelections < ActiveRecord::Migration[6.0]
  def change
    add_column :user_preference_selections, :id, :primary_key
  end
end
