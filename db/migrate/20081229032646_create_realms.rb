class CreateRealms < ActiveRecord::Migration
  def self.up
    create_table :realms do |t|
      t.string :name
      t.string :pseudo_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :realms
  end
end
