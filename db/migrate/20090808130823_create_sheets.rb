class CreateSheets < ActiveRecord::Migration
  def self.up
    create_table :sheets do |t|
      t.string :name
      t.integer :age
      t.string :home
      t.string :colour
      t.string :rank
      t.string :cloak
      t.string :parents
      t.string :artisan
      t.string :mentor
      t.string :friend
      t.string :enemy
      t.integer :fate
      t.integer :persona
      t.boolean :hungry
      t.boolean :angry
      t.boolean :tired
      t.boolean :injured
      t.boolean :sick
      t.string :belief, :limit => 1024
      t.string :goal, :limit => 1024
      t.string :instinct, :limit => 1024
      t.string :gear, :limit => 1024

      t.timestamps
    end
  end

  def self.down
    drop_table :sheets
  end
end
