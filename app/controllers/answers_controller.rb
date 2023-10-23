class AnswersController < ApplicationController
  before_action :authorize
  before_action :set_answer, only: %i[ show update destroy ]

  # GET /answers
  def index
    @answers = Answer.all

    render json: @answers
  end

  # GET /answers/1
  def show
    render json: @answer
  end

  # POST /answers
  def create
    @answer = []
    values = answer_params[:answer]
    question = Question.find(values[0][:question_id])
    survey_id = question.survey_id
    quantity = Question.where(survey_id: survey_id).count

    if values.length == quantity
      values.each do |answer_hash|
        answer = Answer.new(answer_hash.merge(user_id: @user.id))
        if answer.save
          @answer.push(answer)
        else
          render json: answer.errors, status: :unprocessable_entity
          return
        end
      end
    else
      render json: {error: "Responda todas as perguntas para enviar o formulário!", questions: quantity}, status: :unprocessable_entity
    end

    render json: @answer, status: :created unless @answer = []
  end

  # PATCH/PUT /answers/1
  def update
    if @answer.update(answer_params.merge(user_id: @user.id))
      render json: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /answers/1
  def destroy
    @answer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.permit(answer: [:question_id, :answer])
    end
end
