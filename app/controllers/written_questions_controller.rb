class WrittenQuestionsController < ApplicationController
  layout "questions"

  def index
    @questions = WrittenQuestion.paginate(:all, :page => (params[:page] || 1), :per_page => 50, :order => "question_year desc, question_number desc")
  end

  def show
    p = params[:id].split('-', 2)
    question_year = p[0]
    question_number = p[1]

    @question = WrittenQuestion.find_by_question_number_and_question_year(question_number, question_year)
  end
end
