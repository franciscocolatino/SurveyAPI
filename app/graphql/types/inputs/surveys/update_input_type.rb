module Types::Inputs
  module Surveys
    class UpdateInputType < GraphQL::Schema::InputObject
      argument :id, ID, required: true
      argument :title, String, required: false
      argument :closed, Boolean, required: false
      argument :deadline, GraphQL::Types::ISO8601DateTime, required: false
    end
  end
end
