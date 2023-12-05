module Mutations
  module Users
    class CreateUser < BaseMutation

      description "Criando usuário"

      input_object_class Types::Inputs::Users::InputType

      field :token, String, null: false
      field :user, Types::UserType, null: false

      def resolve(**arguments)
        UserCreator.new(arguments).call
      end
    end
  end
end
