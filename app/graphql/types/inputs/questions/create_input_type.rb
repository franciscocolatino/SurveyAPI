module Types::Inputs
  module Questions
    class CreateInputType < GraphQL::Schema::InputObject

      argument :name, String, required: true
      argument :options_answer, [String], required: true
      argument :survey_id, Integer, required: true
      argument :type_question, String, required: true

    end
  end
end
