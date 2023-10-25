class AnswersController < ApplicationController
  before_action :authorize
  before_action :set_answer, only: %i[ show update destroy ]
  before_action :get_survey_id

  # GET /answers
  def index
    @answers = Answer.select(
      'surveys.id',
      'questions.name AS pergunta',
      'answers.answer AS resposta',
      'COUNT(*) AS numero_de_respostas'
    ).joins(:question, :survey)
    .group('surveys.id, answers.answer, questions.name').where(survey_id: @survey_id)
    render json: @answers
  end

  def all_answers
    response = Answer.select(
      'survey.id',
      'questions.name AS pergunta',
      'answers.answer AS resposta',
      'COUNT(*) AS numero_de_respostas'
    ).joins(:question, :survey)
    .group('surveys.id, answers.answer, questions.name')
    .order('surveys.id')
    @answers = {}
    response.each do |answer|
      if @answers[answer.id].nil?
        @answers[answer.id] = []
      end
      @answers[answer.id].push({ pergunta: answer.pergunta, resposta: answer.resposta, numero_de_respostas: answer.numero_de_respostas })
    end
  end

  # GET /answers/1
  def show
    render json: @answer
  end

  # POST /answers
  def create
    @answer = []
    values = answer_params[:answer]
    quantity = Question.where(survey_id: @survey_id).count

    if values.length == quantity
      values.each do |answer_hash|
        answer = Answer.new(answer_hash.merge(user_id: @user.id, survey_id: @survey_id))
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
    render json: @answer, status: :created unless @answer == []
  end

  # PATCH/PUT /answers/1
  def update
    if @answer.update(answer_params.merge(user_id: @user.id, survey_id: @survey_id))
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

    def get_survey_id
      @survey_id = params[:survey_id]
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.permit(:survey_id, answer: [:question_id, :answer])
    end
end
