class Api::V1::LikesController < ApplicationController
  include ActionController::HttpAuthentication::Token
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
      render json: LikeRepresenter.new(like).as_json, status: :created
    else
      render json: like.errors.full_messages.join(", "), status: :unprocessable_entity 
    end 

  end

  def destroy
  end

  private

  def authenticate_user
    # Authorization: Bearer <token>
    token, _options = token_and_options(request)
    user_id = AuthenticationTokenService.decode(token)
    @current_user = User.find(user_id)
  rescue ActiveRecord::RecordNotFound
    render status: :unauthorized
  end

end