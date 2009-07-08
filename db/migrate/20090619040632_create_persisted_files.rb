class CreatePersistedFiles < ActiveRecord::Migration
  def self.up
    create_table :persisted_files do |t|
      t.timestamp :question_date
      t.string :parliament_name
      t.string :parliament_url
      t.string :status
      t.boolean :persisted
      t.boolean :downloaded

      t.timestamps
    end
  end

  def self.down
    drop_table :persisted_files
  end
end
