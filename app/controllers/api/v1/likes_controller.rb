class Api::V1::LikesController < ApplicationController
  include ActionController::HttpAuthentication::Token
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :authenticate_user, only: [:index, :create, :destroy]

  def index
    likes = Like.where(user_id: @current_user.id).limit(limit).offset(params[:offset])
    render json: LikesRepresenter.new(likes).as_json
  end

  def create
    if params.require([:record_id])
      record = Record.find(params.require([:record_id])).first
      like = Like.new(record: record, user: @current_user)
    else
      render json: {"error": "record_id missing"}, status: :unprocessable_entity 
    end

    if like.save
      record.like_count += 1
      record.save
      render json: {"info": "You successfully liked #{record.title}"} , status: :created
    else
      render json: like.errors.full_messages.join(", "), status: :unprocessable_entity 
    end 

  end

  def destroy
    if params.require([:id]).present?
      like = Like.find(params[:id])
      record = Record.find(like.record_id)
      artist = Artist.find(record.artist_id)
      like.destroy
      record.like_count -= 1
      record.save
      render json: { "status": "You have unliked #{record.title} by #{artist.name}" }, status: :ok
    else
      render status: :bad_request 
    end 
  end

  private

  def authenticate_user
    # Authorization: Bearer <token>
    token, _options = token_and_options(request)
    username = AuthenticationTokenService.decode(token)
    @current_user = User.find_by(username: username)
  rescue ActiveRecord::RecordNotFound
    render status: :unauthorized
  end

end