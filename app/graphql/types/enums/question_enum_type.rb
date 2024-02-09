# frozen_string_literal: true
class Types::Enums::QuestionEnumType < Types::BaseEnum
  description "Expense Status enum"

  Question::TYPE_QUESTION.each do |question_export, description|
    value(
      question_export.to_s,
      value: question_export.to_s,
      description: description
    )
  end
end
