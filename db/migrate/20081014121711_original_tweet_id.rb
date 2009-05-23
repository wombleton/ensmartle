class OriginalTweetId < ActiveRecord::Migration
  def self.up
    add_column :tweets, :original, :integer
  end

  def self.down
    remove_column :tweets, :original
  end
end
