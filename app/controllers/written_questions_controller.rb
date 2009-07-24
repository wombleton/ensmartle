class WrittenQuestionsController < ApplicationController
  layout "pages"

  def index
    @questions = WrittenQuestion.paginate(:all, :page => (params[:page] || 1), :per_page => 50)
  end

  def show
    question_number = params[:id].split('-', 2)[0]
    question_year = params[:id].split('-', 2)[1]

    @question = WrittenQuestion.find_by_question_number_and_question_year(question_number, question_year)
  end
end
