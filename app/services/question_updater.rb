class QuestionUpdater < ApplicationService
  def initialize(arguments)
    @data = arguments.to_hash
  end

  def call
    set_question
    update_question
  end

  private

  def set_question
    @question = Question.find(@data[:id])
  end

  def update_question
    if @question.update(@data)
      {question: @question}
    else
      raise GraphQL::ExecutionError.new(@question.errors.full_messages.join(', '))
    end
  end
end
