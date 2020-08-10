class DropDelayedJob < ActiveRecord::Migration[5.2]
  def change
    drop_table :delayed_jobs do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
      t.index :name, unique: true
    end
  end
end
