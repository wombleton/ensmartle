class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :image_path
      t.integer :page_no
      t.integer :document_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
