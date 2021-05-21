class Api::V1::AuthenticationController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  def create
    params.require(:username).inspect
    params.require(:password).inspect

    render json: { token: '123' }, status: :created  
  end

  private

  def parameter_missing(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end
end