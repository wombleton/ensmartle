class AddArmoryIdToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :armory_id, :integer
  end

  def self.down
    remove_column :items, :armory_id
  end
end
