class WrittenQuestion < ActiveRecord::Base
  validates_presence_of :question, :question_number, :question_year

  def to_param
    "#{self.question_number}-#{self.question_year}"
  end
end
