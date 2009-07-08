class AddHtmlToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :page_html, :text
  end

  def self.down
    remove_column :pages, :page_html
  end
end
