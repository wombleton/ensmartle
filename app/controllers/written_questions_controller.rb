class WrittenQuestionsController < ApplicationController
  layout "questions", :except => :rss

  def index
    @questions = WrittenQuestion.paginate(:all, :page => (params[:page] || 1), :per_page => 50, :order => "question_year desc, question_number desc")
  end

  def show
    p = params[:id].split('-', 2)
    question_year = p[0]
    question_number = p[1]

    @question = WrittenQuestion.find(:first, :conditions => ["question_number = ? AND question_year = ?", question_number, question_year], :order => "updated_at desc")
  end

  def rss
    options = {:limit => 250, :order => "updated_at desc"}
    conditions = {}
    conditions[:status] = "reply" unless request.parameters.key?(:all)
    conditions[:subject] = params[:subject] unless params[:subject].nil?
    options[:conditions] = conditions unless conditions.empty?

    @questions = WrittenQuestion.find(:all, options)
    puts @questions.first.inspect
  end
end
