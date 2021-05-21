require 'rails_helper'

RSpec.describe Api::V1::RecordsController, type: :controller do
  context 'GET index' do
    it 'returns records with a max limit fo 100' do
      expect(Record).to receive(:limit).with(100).and_call_original 
      
      get :index, params: { limit: 999 } 
    end
  end

  context 'POST create' do
    let!(:user) { FactoryBot.create(:user, username: "Me", password: "password") }
    let(:record_name) { "Another Hit Record" }
    
    it 'calls SpotifyDataJob.perfom with the correct params' do
      expect(SpotifyDataJob).to receive(:perform_later).with(record_name)
      request.headers["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSJ9.IdCz91KkIj7SrjjxYTsCiThSTAmJFysugQ5aLZ7O390"
      post :create, params: {
        artist: { name: "A Great Artist Name" },
        record: { title: record_name }
      }
    end  
  end
end