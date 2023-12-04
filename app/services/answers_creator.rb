class AnswersCreator
  def initialize(answers, user_id)
    @data = []
    answers.each do |answer|
      @data.append({survey_id: answer.survey_id, question_id: answer.question_id, user_id: user_id, answer: answer.answer})
    end

  def create_answers
    verifyQuantityQuestions(@data[0][:survey_id])
    ids = Answer.insert_all!(@data)
    {IDs: ids.rows.flatten}
  end

  def verifyQuantityQuestions(survey_id)
    response = Survey.joins(:question)
    .select('surveys.id, surveys.closed, surveys.deadline, count(questions.id) AS question_count')
    .where('surveys.id = ?', survey_id)
    .group('surveys.id, surveys.deadline')
    .first
    if @data.length != response[:question_count]
      raise GraphQL::ExecutionError.new('Responda todas as perguntas para enviar o formulário!')
    end
    if (response[:deadline].strftime("%Y-%m-%dT%H:%M:%SZ") < Time.now.strftime("%Y-%m-%dT%H:%M:%SZ") || response[:closed] == true)
      raise GraphQL::ExecutionError.new('Essa pesquisa não aceita mais respostas!')
    end
  end
  end
end
