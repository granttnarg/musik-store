require 'net/http'

class Api::V1::RecordsController < ApplicationController
rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed
  DEFAULT_PAGINATION_LIMIT = 100

  def index
    records = Record.limit(limit).offset(params[:offset])

    render json: RecordsRepresenter.new(records).as_json
  end

  def create
    if record_params[:artist_id].present?
      artist = Artist.find(record_params[:artist_id])
    else 
      artist = Artist.create!(artist_params)
    end 
    record = Record.new(record_params.merge(artist_id: artist.id))

    #send request to spotify API
    SpotifyDataJob.perform_later(record_params[:title])

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

  def limit(value = DEFAULT_PAGINATION_LIMIT)
    # set our pagination limit to 100 or use input
    [ params.fetch(:limit, value).to_i, value ].min
  end

  def record_params
    params.require(:record).permit(:title, :description, :id, :artist_id) 
  end 
  
  def artist_params
    params.require(:artist).permit(:name, :bio, :id)
  end 
end