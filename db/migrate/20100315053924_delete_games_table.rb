class DeleteGamesTable < ActiveRecord::Migration
  def self.up
    drop_table :games
  end

  def self.down
    create_table :games do |t|
      t.string :permalink
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
