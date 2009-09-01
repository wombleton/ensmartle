class AddUsersOpenidFields < ActiveRecord::Migration
  def self.up
    add_column :users, :openid_identifier, :string
    add_index :users, :openid_identifier
  end

  def self.down
    remove_column :users, :openid_identifier
  end
end
