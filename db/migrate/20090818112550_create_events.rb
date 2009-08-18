class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :data, :limit => 512
      t.references :mission
      t.string :by

      t.timestamps
    end

    add_index :events, :created_at
    add_index :events, :mission_id
  end

  def self.down
    drop_table :events
  end
end
