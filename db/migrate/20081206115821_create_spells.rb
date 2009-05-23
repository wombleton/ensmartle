class CreateSpells < ActiveRecord::Migration
  def self.up
    create_table :spells do |t|
      t.string :name
      t.string :icon_base
      t.integer :spell_id
      t.string :tradeskill

      t.timestamps
    end
  end

  def self.down
    drop_table :spells
  end
end
