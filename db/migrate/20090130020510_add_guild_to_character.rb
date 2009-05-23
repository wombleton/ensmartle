class AddGuildToCharacter < ActiveRecord::Migration
  def self.up
    add_column :characters, :guild, :string
    add_column :characters, :armoury_url, :string
  end

  def self.down
    remove_column :characters, :guild, :string
    remove_column :characters, :armoury_url, :string
  end
end
