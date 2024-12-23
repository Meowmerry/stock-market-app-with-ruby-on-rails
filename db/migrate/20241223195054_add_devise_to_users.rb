class AddDeviseToUsers < ActiveRecord::Migration[6.0]
  def up
    # Add 'email' only if it doesn't already exist
    unless column_exists?(:users, :email)
      add_column :users, :email, :string, default: '', null: false
    end

    # Add 'encrypted_password' only if it doesn't already exist
    unless column_exists?(:users, :encrypted_password)
      add_column :users, :encrypted_password, :string, default: '', null: false
    end

    # Add the other Devise columns only if they don't already exist
    unless column_exists?(:users, :reset_password_token)
      add_column :users, :reset_password_token, :string
    end

    unless column_exists?(:users, :reset_password_sent_at)
      add_column :users, :reset_password_sent_at, :datetime
    end

    unless column_exists?(:users, :remember_created_at)
      add_column :users, :remember_created_at, :datetime
    end
  end

  def down
    remove_column :users, :email if column_exists?(:users, :email)
    remove_column :users, :encrypted_password if column_exists?(:users, :encrypted_password)
    remove_column :users, :reset_password_token if column_exists?(:users, :reset_password_token)
    remove_column :users, :reset_password_sent_at if column_exists?(:users, :reset_password_sent_at)
    remove_column :users, :remember_created_at if column_exists?(:users, :remember_created_at)
  end
end
