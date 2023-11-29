class ChangeTypeQuestionToBeEnumInQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :type_question

    add_column :questions, :type_question, :integer, default: 0

  end
end
