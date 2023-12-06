module Queries
  module Surveys
    class ShowSurvey < Queries::BaseQuery

      argument :id, ID, required: true

      type Types::SurveyType, null: false

      def resolve(id:)
        authenticate_user(role: 'adm')
        begin
          Survey.find_by(id: id)
        rescue ActiveRecord::RecordNotFound => e
          raise GraphQL::ExecutionError.new(e.message)
        end
      end
    end
  end
end
