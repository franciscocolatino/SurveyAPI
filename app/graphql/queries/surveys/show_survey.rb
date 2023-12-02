module Queries
  module Surveys
    class ShowSurvey < Queries::BaseQuery

      argument :id, ID, required: true

      type Types::SurveyType, null: false

      def resolve(id:)
        begin
          authenticate_user(role: 'adm')
          survey = Survey.find_by(id: id)
        rescue ActiveRecord::RecordNotFound => e
          raise GraphQL::ExecutionError.new(e.message)
        rescue StandardError => e
          raise GraphQL::ExecutionError.new(e.message)
        end
      end
    end
  end
end
