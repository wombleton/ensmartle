class WrittenQuestion < ActiveRecord::Base
  validates_presence_of :question, :asker, :portfolio, :question_number, :question_year
end
