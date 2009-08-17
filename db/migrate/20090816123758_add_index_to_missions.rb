class AddIndexToMissions < ActiveRecord::Migration
  def self.up
    add_index(:missions, :permalink)
    add_index(:rolls, :mission_id)
    change_column :missions, :permalink, :string, :limit => 60
  end

  def self.down
    remove_index(:missions, :permalink)
    remove_index(:rolls, :mission_id)
    change_column :missions, :permalink, :string, :limit => 255
  end
end
