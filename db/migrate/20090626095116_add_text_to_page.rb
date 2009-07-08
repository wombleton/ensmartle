class AddTextToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :keywords, :text
  end

  def self.down
    remove_column :pages, :keywords
  end
end
