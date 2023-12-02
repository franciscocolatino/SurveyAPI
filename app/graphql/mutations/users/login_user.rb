module Mutations
  module Users
    class LoginUser < BaseMutation
      require 'json_web_token'

      description "Logando usuário para obter o token de acesso"

      argument :username, String, required: true
      argument :password, String, required: true

      field :token, String, null: false
      field :user, Types::UserType, null: false

      def resolve(username:, password:)
        user = User.find_by(username: username)
        if user && user.authenticate(password)

          token = JsonWebToken.encode({user_id: user.id, role: user.role})
          if token
            return {user: user, token: token};
          else
            raise GraphQL::ExecutionError.new(I18n.t('errors.user.token_not_created'))
          end
        else
          raise GraphQL::ExecutionError.new('Usuário ou senha inválido!')
        end
      end
    end
  end
end
