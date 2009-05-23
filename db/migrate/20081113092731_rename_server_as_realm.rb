class RenameServerAsRealm < ActiveRecord::Migration
  def self.up
    remove_column :characters, :server
    add_column :characters, :realm, :string
  end

  def self.down
    remove_column :characters, :realm
    add_column :characters, :server, :string
  end
end
