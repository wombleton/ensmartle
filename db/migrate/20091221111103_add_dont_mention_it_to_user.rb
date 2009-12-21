class AddDontMentionItToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :stance, :string
    add_column :users, :name, :string
    add_column :users, :url, :string
    add_column :users, :profile_image_url, :string
    add_column :users, :bad_url, :boolean
    add_column :users, :tweetblocker_rating, :string, :limit => 5
    add_column :users, :forgiven, :boolean
  end

  def self.down
    remove_column :users, :stance
    remove_column :users, :name
    remove_column :users, :url
    remove_column :users, :profile_image_url
    remove_column :users, :bad_url, :boolean
    remove_column :users, :tweetblocker_rating
    remove_column :users, :forgiven, :boolean
  end
end
