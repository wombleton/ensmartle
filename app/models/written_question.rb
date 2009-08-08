class WrittenQuestion < ActiveRecord::Base
  validates_presence_of :question, :question_number, :question_year

  def to_param
    "#{self.question_year}-#{self.question_number}-#{self.short_form.parameterize}"
  end

  def short_form
    self.question.split(' ')[0, 10].join(' ')
  end

  def parliament_link
    "http://www.parliament.nz/en-NZ/?document=QWA_#{self.question_number}_#{self.question_year}"
  end
end
