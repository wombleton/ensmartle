class AddPropertiesToSpells < ActiveRecord::Migration
  def self.up
    add_column :spells, :tooltip, :text
  end

  def self.down
  end
end
