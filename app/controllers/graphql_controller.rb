# frozen_string_literal: true

class GraphqlController < ApplicationController

  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      current_user: current_user,
      decoded_token: decode_token
    }
    result = SurveyApiSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  def current_user
    if decode_token
      data = decode_token
      user = User.find_by({id: data[:user_id]}) if data[:user_id].present?
      @current_user ||= user if (data[:user_id].present? && data[:role].present?)
    end
  end

  def decode_token
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last if auth_header
    if token
      begin
        @decoded_token ||= JsonWebToken.decode(token)
      rescue ActiveRecord::RecordNotFound => e
        raise GraphQL::ExecutionError.new(e.message)
      rescue JWT::DecodeError => e
        raise GraphQL::ExecutionError.new(e.message)
      rescue StandardError => e
        raise GraphQL::ExecutionError.new(e.message)
      end
    end
  end

  private

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end
end
