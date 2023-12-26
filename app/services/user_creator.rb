class UserCreator < ApplicationService
  def initialize(arguments)
    @arguments = arguments.to_hash
  end

  def call
    create_user
  end

  private

  def create_user
    user = User.new(@arguments)
    begin
      user.save
      token = JsonWebToken.encode({user_id: user.id, role: user.role})
      if token
        {user: user, token: token};
      else
        raise GraphQL::ExecutionError.new(I18n.t('errors.user.token_not_created'))
      end
    rescue Exception => e
      raise GraphQL::ExecutionError.new(e)
    end
  end
end
