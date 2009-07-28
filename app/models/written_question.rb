class WrittenQuestion < ActiveRecord::Base
  validates_presence_of :question, :question_number, :question_year

  def to_param
    "#{self.question_year}-#{self.question_number}"
  end
end
