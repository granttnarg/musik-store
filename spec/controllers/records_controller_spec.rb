require 'rails_helper'
require 'request_helper'

RSpec.describe Api::V1::RecordsController, type: :controller do
  context 'GET index' do
    it 'returns records with a max limit fo 100' do
      expect(Record).to receive(:limit).with(100).and_call_original 
      
      get :index, params: { limit: 999 } 
    end
  end

  context 'POST create' do
    let!(:user) { FactoryBot.create(:user, username: "Me", password: "password") }
    let(:record_params) { {title: "Another Hit Record", genre: "pop", description: "A great description of a hit record"} }
    
    it 'create a record when an auth token and correct info is sent' do
      request.headers["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSJ9.IdCz91KkIj7SrjjxYTsCiThSTAmJFysugQ5aLZ7O390"
      post :create, params: {
        artist: { name: "A Great Artist Name" },
        record: record_params
      }
      expect(JSON.parse(response.body).first["id"]).to eq(1)
      expect(JSON.parse(response.body).first["title"]).to eq(record_params[:title])
    end  
  end
end