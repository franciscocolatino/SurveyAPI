module Queries
  module Surveys
    class MySurveys < Queries::BaseQuery

      type [Types::SurveyType], null: false

      def resolve
        authenticate_user(role: 'user')
        Survey.where(user_id: context[:current_user].id)
      end
    end
  end
end
