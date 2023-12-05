module Types::Inputs
  module Surveys
    class CreateInputType < GraphQL::Schema::InputObject
      argument :title, String, required: true
      argument :closed, Boolean, required: true
      argument :deadline, GraphQL::Types::ISO8601DateTime, required: true
    end
  end
end
