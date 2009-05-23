class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.text :text
      t.string :profile_image_url
      t.string :iso_language_code
      t.integer :from_user_id
      t.string :from_user
      t.integer :to_user_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
