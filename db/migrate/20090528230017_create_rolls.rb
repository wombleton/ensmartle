class CreateRolls < ActiveRecord::Migration
  def self.up
    create_table :rolls do |t|
      t.string :by
      t.integer :number
      t.string :value
      t.boolean :exploded
      t.integer :mission_id
      t.string :ip_address

      t.timestamps
    end
  end

  def self.down
    drop_table :rolls
  end
end
