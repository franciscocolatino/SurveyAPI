class SurveysController < ApplicationController
  before_action :authorize
  before_action :adm_only, except: :index
  before_action :set_survey, only: %i[ show update destroy ]

  # GET /surveys
  def index
    #@surveys = @user.surveys.all
    # @surveys = Survey.where("closed = false")
    @surveys = Survey.where("closed = false and deadline > ?", Time.now.strftime("%Y-%m-%dT%H:%M:%SZ"))

    render json: @surveys
  end
  # GET /surveys_all ADM only
  def all_surveys
    @surveys = Survey.select('surveys.*, users.username AS created_by').joins(:user).all
    render json: @surveys
  end
  # GET /surveys/1
  def show
    render json: @survey
  end

  # POST /surveys
  def create
    @survey = Survey.new(survey_params.merge(user: @user))

    if @survey.save
      render json: @survey, status: :created, location: @survey
    else
      render json: @survey.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /surveys/1
  def update
    if @survey.update(survey_params)
      render json: @survey
    else
      render json: @survey.errors, status: :unprocessable_entity
    end
  end

  # DELETE /surveys/1
  def destroy
    @survey.destroy
  end

  private

    def set_survey
      @survey = Survey.find(params[:id])
    end

    def survey_params
      params.require(:survey).permit(:title, :closed, :deadline)
    end
end
