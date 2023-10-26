# app/services/answer_service.rb
module AnswerService
  def self.fetch_survey_details(survey_id)
    Survey.joins(:question)
    .select('surveys.id, surveys.closed, surveys.deadline, count(questions.id) AS question_count')
    .where('surveys.id = ?', survey_id)
    .group('surveys.id, surveys.deadline')
    .first
  end
  def self.fetch_index(survey_id)
    Answer.select(
      'surveys.id',
      'questions.name AS pergunta',
      'answers.answer AS resposta',
      'COUNT(*) AS numero_de_respostas'
    ).joins(:question, :survey)
    .group('surveys.id, answers.answer, questions.name').where(survey_id: survey_id)
  end
  def self.fetch_all_answers
    Answer.select(
      'surveys.id',
      'questions.name AS pergunta',
      'answers.answer AS resposta',
      'COUNT(*) AS numero_de_respostas'
    ).joins(:question, :survey)
    .group('surveys.id, answers.answer, questions.name')
    .order('surveys.id')
  end
end
