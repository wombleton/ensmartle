class AddPlayerFlagToSheets < ActiveRecord::Migration
  def self.up
    add_column :sheets, :player, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :sheets, :player
  end
end
