class Api::V1::AuthenticationController < ApplicationController
  class AuthenticationError < StandardError; end
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from AuthenticationError, with: :handle_unauthenticated

  def create
    raise AuthenticationError unless user.authenticate(params.require(:password))
    jwt_token = AuthenticationTokenService.call(@user.id)
    render json: { token: jwt_token }, status: :created  
  end

  def user
    @user ||= User.find_by(username: params.require(:username))
  end 

  private

  def parameter_missing(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end

  def handle_unauthenticated
    head :unauthorized
  end
end