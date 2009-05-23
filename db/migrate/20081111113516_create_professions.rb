class CreateProfessions < ActiveRecord::Migration
  def self.up
    create_table :professions do |t|
      t.integer :character_id
      t.integer :tradeskill_id
      t.integer :max
      t.integer :value

      t.timestamps
    end
  end

  def self.down
    drop_table :professions
  end
end
