class SurveyUpdater < ApplicationService
  def initialize(arguments, user_id)
    @data = arguments.to_hash
    @id = @data[:id]
    @data.except!(:id)
    @user_id = user_id
  end

  def call
    set_survey
    update_survey
  end

  private


  def set_survey
    @survey = Survey.find(@id)
  end

  def update_survey
    if @survey.update(@data.merge(user_id: @user_id))
      {survey: @survey}
    else
      raise GraphQL::ExecutionError.new(@survey.errors.full_messages.join(', '))
    end
  end
end
