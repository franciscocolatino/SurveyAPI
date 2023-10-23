class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user


  # validate :check_all_answers
  # def check_all_answers
  #   if question_id.present?
  #     question = Question.find(question_id)
  #     survey_id = question.survey_id
  #     count = Question.where(survey_id: survey_id).count
  #     puts count
  #   else
  #     errors.add(:question_id, "Não pode ser vazio")
  #   end
  # end
end
