# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject

    field :my_surveys, resolver: Queries::Surveys::MySurveys
    field :all_surveys, resolver: Queries::Surveys::AllSurveys
    field :open_surveys, resolver: Queries::Surveys::OpenSurveys
    field :show_survey, resolver: Queries::Surveys::ShowSurvey
    field :quantity_answers, resolver: Queries::Answers::QuantityAnswers
    field :all_quantity_answer, resolver: Queries::Answers::AllQuantityAnswers

    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :answers, [Types::AnswerType], null: false,
      description: "An example field to get answers"
    def answers
      Answer.all
    end
    # field :surveys, [Types::SurveyType], null: false,
    #   description: "Field to get surveys"
    # def surveys
    #   Survey.preload(:question, :answer)
    # end

  end
end
