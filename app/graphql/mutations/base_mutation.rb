# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    # null false

    def authenticate_user(role:)
      unless context[:current_user]
        raise GraphQL::ExecutionError.new(I18n.t('errors.users.unauthenticated'))
      end
      if role == 'adm' && context[:current_user].role == 'user'
        raise GraphQL::ExecutionError.new(I18n.t('errors.users.noPermission'))
      end
    end

  end
end
