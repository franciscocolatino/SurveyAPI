class QuestionsController < ApplicationController
  before_action :authorize
  before_action :adm_only, except: :index
  before_action :set_question, only: %i[ show update destroy ]
  before_action :get_survey_id, except: :destroy

  # GET /surveys/:survey_id/questions
  def index
    @questions = Question.where(survey_id: @survey_id)

    render json: @questions
  end

  # POST /surveys/:survey_id/questions
  def create
    @question = Question.new(question_params.merge(survey_id: @survey_id))

    if @question.save
      render json: @question, status: :created
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /surveys/:survey_id/questions/1
  def update
    if @question.update(question_params.merge(survey_id: @survey_id))
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
  end

  private

    def set_question
      @question = Question.find(params[:id])
    end

    def get_survey_id
      @survey_id = params[:survey_id]
    end

    def question_params
      params.require(:question).permit(:name, :type_question, options_answer: [])
    end
end
