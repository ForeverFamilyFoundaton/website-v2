class AddConfirmableToDevise < ActiveRecord::Migration[5.2]
  # Note: You can't use change, as User.update_all will fail in the down migration
  def up
    add_column :users, :unconfirmed_email, :string
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # users as confirmed, do the following
    User.update_all confirmed_at: DateTime.now
    # All existing user accounts should be able to log in after this.
  end

  def down
    remove_columns :users, :unconfirmed_email
  end
end
