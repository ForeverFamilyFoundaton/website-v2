class UpdateFamilyMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :family_members, :role, :string
    add_column :family_members, :family_id, :integer
  end
end
