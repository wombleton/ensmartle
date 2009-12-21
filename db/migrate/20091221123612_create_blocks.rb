class CreateBlocks < ActiveRecord::Migration
  def self.up
    create_table :blocks do |t|
      t.references :user
      t.references :twit

      t.timestamps
    end
  end

  def self.down
    drop_table :blocks
  end
end
