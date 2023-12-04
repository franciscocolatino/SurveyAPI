module Types
  module Inputs
    module Questions
      class UpdateInputType < Types::BaseInputObject
        argument :id, ID, required: true
        argument :name, String, required: false
        argument :options_answer, [String], required: false
        argument :survey_id, Integer, required: false
        argument :type_question, String, required: false
      end
    end
  end
end
