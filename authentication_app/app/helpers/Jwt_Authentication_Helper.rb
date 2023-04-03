module JwtAuthenticationHelper
require 'json_web_token'
    def authorize_request
      header = request.headers['Authorization']
      token = header.split(' ').last if header
  
      begin
        @decoded = JsonWebToken.decode(token)
        @current_user = User.find(@decoded[:user_params])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end
  end
  