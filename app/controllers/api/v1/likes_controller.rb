class Api::V1::LikesController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy] 

  def index; end

  def create
    artist = Record.find(params.require(:record_id))
    binding.pry
    Like.create(artist: artist, user: current_user)
  end

  def destroy
  end

  private

  def authenticate_user
    # Authorization: Bearer <token>
    token, _options = token_and_options(request)
    user_id = AuthenticationTokenService.decode(token)
    @user = User.find(user_id)
  rescue ActiveRecord::RecordNotFound
    render status: :unauthorized
  end

end