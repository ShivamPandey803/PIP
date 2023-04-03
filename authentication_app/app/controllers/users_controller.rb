class UsersController < ApplicationController
include JwtAuthenticationHelper
before_action :authorize_request, except: :create
  
# POST /register
def create
    user = User.create!(user_params)
    auth_token = user.jwt
    render json: { auth_token: auth_token }, status: :created
end
  
# POST /login
def login
    user = User.from_credentials(params[:email], params[:password])
    if user
    auth_token = user.jwt
    render json: { auth_token: auth_token }
    else
    render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
end
  
private
  
def user_params
    params.permit(:username, :email, :password, :password_confirmation)
    end
end
  