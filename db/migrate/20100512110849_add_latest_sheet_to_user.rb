class AddLatestSheetToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :latest_sheet_id, :integer
  end

  def self.down
    remove_column :users, :latest_sheet_id
  end
end
