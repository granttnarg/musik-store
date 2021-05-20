class Api::V1::RecordsController < ApplicationController
rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  def index
    records = Record.all

    render json: RecordsRepresenter.new(records).as_json
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

    head :no_content
  end
 
  private
  def record_params
    params.require(:record).permit(:title, :description, :id) 
  end   
end