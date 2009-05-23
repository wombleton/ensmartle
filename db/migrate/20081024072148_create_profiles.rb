class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :screen_name
      t.string :location
      t.string :mapped_location

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
