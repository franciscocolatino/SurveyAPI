module Mutations
  module Users
    class CreateUser < BaseMutation
      require 'json_web_token'

      description "Criando usuário"

      argument :username, String, required: true
      argument :password, String, required: true
      argument :role, String, required: true

      field :token, String, null: false
      field :user, Types::UserType, null: false

      def resolve(username:, password:, role:)
        user = User.new(username: username, password: password, role: role)
        if user.save
          token = JsonWebToken.encode({user_id: user.id, role: user.role})
          if token
            {user: user, token: token};
          else
            raise GraphQL::ExecutionError.new(I18n.t('errors.user.token_not_created'))
          end
        else
          raise GraphQL::ExecutionError.new(user.errors.full_messages.join(', '))
        end
      end
    end
  end
end
