class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.datetime :date
      t.string :document_type
      t.string :title
      t.string :pdf_name
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
