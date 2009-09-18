class AddResultToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :result, :string
  end

  def self.down
    remove_column :events, :result
  end
end
