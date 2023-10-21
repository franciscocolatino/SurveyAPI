class ApplicationController < ActionController::API

  def encode_token(payload)
    JWT.encode(payload, 'secret')
  end

  def decode_token
    auth_header = request.headers['Authorization']
    if auth_header
      token = auth_header.split(' ').last
    begin
      JWT.decode(token, 'secret', true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end
end

  def authorized_user
    decoded_token = decode_token()
    puts decoded_token
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by({id: user_id})
    end
  end


  def authorize
    render json: {message: "Você precisa estar logado"}, status: :unauthorized unless authorized_user
  end

  protected

  def adm_only
    render json: {message: "Apenas Coordenadores de Pesquisa possuem acesso a isso"}, status: :forbidden unless @user.role.downcase == "adm"
  end
end
