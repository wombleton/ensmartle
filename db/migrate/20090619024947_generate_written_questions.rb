class GenerateWrittenQuestions < ActiveRecord::Migration
  def self.up
    create_table :written_questions do |t|
      t.text :question
      t.text :answer
      t.string :status
      t.integer :question_number
      t.integer :question_year
      t.string :asker_url
      t.string :asker_name
      t.string :portfolio_url
      t.string :portfolio_name
      t.string :respondent_url
      t.string :respondent_name
      t.date :date_asked
      t.string :subject

      t.timestamps
    end
  end

  def self.down
    drop_table(:questions)
  end
end
