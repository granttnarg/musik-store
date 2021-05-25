require 'net/http'

class Api::V1::RecordsController < ApplicationController
  class AuthenticationError < StandardError; end
  include ActionController::HttpAuthentication::Token

  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from AuthenticationError, with: :handle_unauthenticated

  before_action :authenticate_user, only: [:create, :destroy] 

  def index
    records = Record.limit(limit).offset(params[:offset])
1
    render json: RecordsRepresenter.new(records).as_json
  end

  def create
    if record_params[:artist_id].present?
      artist = Artist.find(record_params[:artist_id])
    else 
      artist = Artist.create!(artist_params)
    end 
    record = Record.new(record_params.merge(artist_id: artist.id))
    
    if record.save
      render json: RecordsRepresenter.new(record).as_json, status: :created
    else 
      render json: record.errors.full_messages.join(", "), status: :unprocessable_entity
    end
  end

  def destroy
    if params[:id].present?
      Record.find(params[:id]).destroy!
      render json: { "status": "Record succesfully deleted" }, status: :ok
    else
      render status: :bad_request 
    end 
  end
 
  private

  def authenticate_user
    # Authorization: Bearer <token>
    token, _options = token_and_options(request)
    user_id = AuthenticationTokenService.decode(token)
    User.find(user_id)
  rescue ActiveRecord::RecordNotFound
    render status: :unauthorized
  end

  def record_params
    params.require(:record).permit(:title, :description, :genre, :album, :artwork_url, :like_count, :id, :artist_id) 
  end 
  
  def artist_params
    params.require(:artist).permit(:name, :bio, :id)
  end
end