class QuestionCreator < ApplicationService
  def initialize(arguments)
    @data = arguments.to_hash
  end

  def call
    create_question
  end

  private

  def create_question
    question = Question.new(@data)
    if question.save
      {question: question}
    else
      raise GraphQL::ExecutionError.new(question.errors.full_messages.join(', '))
    end
  end
end
