module Mutations
  module Users
    class LoginUser < BaseMutation

      description "Logando usuário para obter o token de acesso"
      input_object_class Types::Inputs::Users::InputType

      field :token, String, null: false
      field :user, Types::UserType, null: false

      def resolve(**arguments)
        UserLogin.new(arguments).call
      end
    end
  end
end
