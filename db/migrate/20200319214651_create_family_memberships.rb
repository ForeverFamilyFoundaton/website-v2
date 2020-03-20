class CreateFamilyMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :family_memberships do |t|
      t.references :family
      t.references :user
      t.string :role

      t.timestamps
    end
  end
end
