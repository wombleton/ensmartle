class ChangeProfessions < ActiveRecord::Migration
  def self.up
    remove_column :professions, :tradeskill_id
    add_column :professions, :name, :string
  end

  def self.down
    add_column :professions, :tradeskill_id, :integer
    remove_column :professions, :name
  end
end
