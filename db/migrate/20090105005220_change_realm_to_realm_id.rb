class ChangeRealmToRealmId < ActiveRecord::Migration
  def self.up
    remove_column :characters, :realm
    add_column :characters, :realm_id, :integer
  end

  def self.down
    remove_column :characters, :realm_id
    add_column :characters, :realm, :string
  end
end
