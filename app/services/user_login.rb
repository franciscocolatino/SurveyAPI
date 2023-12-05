class UserLogin < ApplicationService
  def initialize(arguments)
    @username = arguments[:username]
    @password = arguments[:password]
  end

  def call
    set_survey
    login
  end

  private

  def login
    if @user && @user.authenticate(@password)

      token = JsonWebToken.encode({user_id: @user.id, role: @user.role})
      if token
        return {user: @user, token: token};
      else
        raise GraphQL::ExecutionError.new(I18n.t('errors.user.token_not_created'))
      end
    else
      raise GraphQL::ExecutionError.new('Usuário ou senha inválido!')
    end
  end

  def set_survey
    @user = User.find_by(username: @username)
  end
end
