class ChangeUpRecipesToSpells < ActiveRecord::Migration
  def self.up
    remove_column :recipes, :item_id
    add_column :recipes, :spell_id, :integer, :null => false
    remove_column :recipes, :character_id
    add_column :recipes, :profession_id, :integer, :null => false
  end

  def self.down
    remove_column :recipes, :spell_id
    add_column :recipes, :item_id, :integer
    remove_column :recipes, :profession_id
    add_column :recipes, :character_id, :integer
  end
end
