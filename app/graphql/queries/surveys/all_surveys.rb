module Queries
  module Surveys
    class AllSurveys < Queries::BaseQuery

      type [Types::SurveyType], null: false

      def resolve
        authenticate_user(role: 'adm')
        Survey.preload(:question)
      end
    end
  end
end
