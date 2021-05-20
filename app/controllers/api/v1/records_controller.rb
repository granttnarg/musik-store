class Api::V1::RecordsController < ApplicationController
rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  def index
    render json: Record.all
  end

  def create
    record = Record.new(record_params)

    if record.save
      render json: record, status: :created
    else 
      render json: record.errors.full_messages.join(", "), status: :unprocessable_entity
    end
  end

  def destroy
    record = Record.find(params[:id]).destroy!

    head :content
  end
 
  private
  def record_params
    params.require(:record).permit(:title, :description, :id) 
  end   
end