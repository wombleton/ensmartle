class AddPseudoIds < ActiveRecord::Migration
  def self.up
    add_column :professions, :pseudo_id, :string
    add_column :characters, :pseudo_id, :string
    add_column :users, :pseudo_id, :string
  end

  def self.down
    remove_column :professions, :pseudo_id
    remove_column :characters, :pseudo_id
    remove_column :users, :pseudo_id
  end
end
