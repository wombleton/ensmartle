class CreateComponents < ActiveRecord::Migration
  def self.up
    create_table :components do |t|
      t.integer :item_id
      t.integer :reagent_id
    end
  end

  def self.down
    drop_table :components
  end
end
