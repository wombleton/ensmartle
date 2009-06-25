class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.datetime :date
      t.string :type
      t.string :title
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
