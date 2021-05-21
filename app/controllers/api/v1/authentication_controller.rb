class Api::V1::AuthenticationController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  def create
    user = User.find_by(username: params.require(:username))
    params.require(:password).inspect
    jwt_token = AuthenticationTokenService.call(user.id)
    render json: { token: jwt_token }, status: :created  
  end

  private

  def parameter_missing(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end
end