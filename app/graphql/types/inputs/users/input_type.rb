module Types::Inputs
  module Users
    class InputType < GraphQL::Schema::InputObject
      argument :username, String, required: true
      argument :password, String, required: true
      argument :role, String, required: false
    end
  end
end
