module Queries
  module Surveys
    class OpenSurveys < Queries::BaseQuery

      type [Types::SurveyType], null: false

      def resolve
        authenticate_user(role: 'user')
        Survey.where("closed = false and deadline > ?", Time.now.strftime("%Y-%m-%dT%H:%M:%SZ"))
      end
    end
  end
end
