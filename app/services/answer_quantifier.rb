class AnswerQuantifier < ApplicationService
  def initialize(survey_id)
    @survey_id = survey_id
  end

  def call
    if (@survey_id == nil)
      all_quantify_answers
    else
      quantify_answers
    end
  end

  private

  def quantify_answers
    begin
      Answer.select(
        'surveys.id AS survey_id',
        'questions.name AS question_name',
        'answers.answer AS answer',
        'COUNT(*) AS quantity'
      ).joins(:question, :survey)
      .group('surveys.id, answers.answer, questions.name').where(survey_id: @survey_id)
    rescue ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError.new(e.message)
    rescue StandardError => e
      raise GraphQL::ExecutionError.new(e.message)
    end
  end

  def all_quantify_answers
    begin
      Answer.select(
          'surveys.id AS survey_id',
          'questions.name AS question_name',
          'answers.answer AS answer',
          'COUNT(*) AS quantity'
        ).joins(:question, :survey)
        .group('surveys.id, answers.answer, questions.name')
        .order('surveys.id')
    rescue ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError.new(e.message)
    rescue StandardError => e
      raise GraphQL::ExecutionError.new(e.message)
    end
  end
end
