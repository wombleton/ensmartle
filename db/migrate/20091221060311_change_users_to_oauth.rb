class ChangeUsersToOauth < ActiveRecord::Migration
  def self.up
    add_column :users, :token, :string, :limit => 128
    add_column :users, :token_expires_at, :datetime
    add_column :users, :atoken, :string
    add_column :users, :asecret, :string
    remove_column :users, :crypted_password
    remove_column :users, :password_salt
    remove_column :users, :password_confirmation
    remove_column :users, :token
    remove_column :users, :token_expires_at
    add_column :users, :screen_name, :string, :limit => 30
    remove_column :users, :login
    remove_column :users, :persistence_token
  end

  def self.down
    remove_column :users, :token
    remove_column :users, :token_expires_at
    
    remove_column :users, :atoken
    remove_column :users, :asecret
    add_column :users, :crypted_password, :string
    add_column :users, :password_salt, :string
    add_column :users, :password_confirmation, :string
    add_column :users, :token_expires_at, :string
    remove_column :users, :screen_name
    add_column :users, :login, :string, :null => false
    add_column :users, :persistence_token, :string
  end
end
