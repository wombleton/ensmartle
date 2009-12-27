class AddLastTweetToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :last_tweet_id, :integer
    add_column :users, :last_tweet, :string
  end

  def self.down
    remove_column :users, :last_tweet_id
    remove_column :users, :last_tweet
  end
end
