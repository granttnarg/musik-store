class Api::V1::RecordsController < ApplicationController
rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  def index
    records = Record.all

    render json: RecordsRepresenter.new(records).as_json
  end

  def create
    artist = Artist.create!(artist_params)
    record = Record.new(record_params.merge(artist_id: artist.id))

    if record.save
      render json: RecordsRepresenter.new(record).as_json, status: :created
    else 
      render json: record.errors.full_messages.join(", "), status: :unprocessable_entity
    end
  end

  def destroy
    record = Record.find(params[:id]).destroy!

    head :no_content
  end
 
  private
  def record_params
    params.require(:record).permit(:title, :description, :id) 
  end 
  
  def artist_params
    params.require(:artist).permit(:name, :bio, :id)
  end 
end