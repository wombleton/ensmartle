class CreateMissions < ActiveRecord::Migration
  def self.up
    create_table :missions do |t|
      t.string :title
      t.text :summary
      t.integer :game_id
      t.string :permalink

      t.timestamps
    end
  end

  def self.down
    drop_table :missions
  end
end
