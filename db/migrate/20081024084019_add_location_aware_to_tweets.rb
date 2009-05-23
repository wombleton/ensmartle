class AddLocationAwareToTweets < ActiveRecord::Migration
  def self.up
    add_column :categories, :location_aware, :boolean, :default => false
  end

  def self.down
    remove_column :categories, :location_aware
  end
end
