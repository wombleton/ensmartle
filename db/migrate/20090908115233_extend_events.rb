class ExtendEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :event_type, :string, :limit => 15
    add_column :events, :exploded, :boolean
    add_column :events, :sheet_id, :integer
    remove_column :events, :by
  end

  def self.down
    remove_column :events, :event_type
    remove_column :events, :exploded
    remove_column :events, :sheet_id
    add_column :events, :by, :string
  end
end
