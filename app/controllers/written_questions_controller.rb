class WrittenQuestionsController < ApplicationController
  layout "pages"

  def index
    @questions = WrittenQuestion.paginate(:all, :page => (params[:page] || 1), :per_page => 50)
  end

  def show
    p = params[:id].split('-', 2)
    question_year = p[0]
    question_number = p[1]

    @question = WrittenQuestion.find_by_question_number_and_question_year(question_number, question_year)
  end
end
