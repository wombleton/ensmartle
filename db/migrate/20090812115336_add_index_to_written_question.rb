class AddIndexToWrittenQuestion < ActiveRecord::Migration
  def self.up
    add_index(:written_questions, [:question_year, :question_number])
    add_index(:written_questions, :updated_at)
  end

  def self.down
    remove_index :written_questions, :question_year_and_question_number
    remove_index :written_questions, :updated_at
  end
end
