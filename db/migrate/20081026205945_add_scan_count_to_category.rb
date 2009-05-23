class AddScanCountToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :scan_count, :integer, :default => 0
  end

  def self.down
    remove_column :categories, :scan_count
  end
end
