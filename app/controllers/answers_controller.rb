class AnswersController < ApplicationController
  before_action :authorize
  before_action :set_answer, only: %i[ show update destroy ]
  before_action :get_survey_id

  # GET /surveys/:survey_id/answers
  def index
    @answers = AnswerService.fetch_index(@survey_id)
    render json: @answers
  end
  # GET /answers
  def all_answers
    response = AnswerService.fetch_all_answers
    @answers = {}
    response.each do |answer|
      if @answers[answer.id].nil?
        @answers[answer.id] = []
      end
      @answers[answer.id].push({ pergunta: answer.pergunta, resposta: answer.resposta, numero_de_respostas: answer.numero_de_respostas })
    end
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
    query_result = AnswerService.fetch_survey_details(@survey_id)
    if (values.length != query_result[:question_count])
      render json: { error: "Responda todas as perguntas para enviar o formulário!", questions: query_result[:question_count] }, status: :unprocessable_entity
      return
    end
    if (query_result[:deadline].strftime("%Y-%m-%dT%H:%M:%SZ") < Time.now.strftime("%Y-%m-%dT%H:%M:%SZ") || query_result[:closed] == true)
      render json: { error: "Essa pesquisa não aceita mais respostas", deadline: query_result[:deadline], closed: query_result[:closed] }, status: :unprocessable_entity
      return
    end
    values.each do |answer_hash|
      answer = Answer.new(answer_hash.merge(user_id: @user.id, survey_id: @survey_id))
      if answer.save
        @answer.push(answer)
      else
        render json: answer.errors, status: :unprocessable_entity
        return
      end
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
