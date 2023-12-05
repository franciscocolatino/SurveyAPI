class SurveyCreator < ApplicationService
  def initialize(arguments, user_id)
    @data = arguments.to_hash
    @user_id = user_id
  end

  def call
    create_survey
  end

  private

  def create_survey
    survey = Survey.new(@data.merge(user_id: @user_id))
    if survey.save
      {survey: survey}
    else
      raise GraphQL::ExecutionError.new(survey.errors.full_messages.join(', '))
    end
  end
end
