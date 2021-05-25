require 'rails_helper'
require 'request_helper'

RSpec.describe Api::V1::RecordsController, type: :controller do
  context 'GET index' do
    let!(:artist) { FactoryBot.create(:artist, name: "The Beatles") }
    let!(:record) { FactoryBot.create(:record, title: "Let it be", genre: "pop", artist: artist) }
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
      expect { post :create, params: {
        artist: { name: "A Great Artist Name" },
        record: record_params
        }
      }.to change{ Record.count }.by(1)
    end  
  end

  context 'DELETE record' do
    let!(:user) { FactoryBot.create(:user, username: "Me", password: "password") }
    let!(:artist) { FactoryBot.create(:artist, name: "The Beatles") }
    let!(:record) { FactoryBot.create(:record, title: "Another Hit Record", artist: artist, genre: "pop", description: "A great description of a hit record") }

    it "It should delete a record with a valid ID and auth token" do
      request.headers["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSJ9.IdCz91KkIj7SrjjxYTsCiThSTAmJFysugQ5aLZ7O390"
      expect { delete :destroy,  params: {id: 1 } }.to change { Record.count }.by(-1)
    end

    it "should change Record count with invalid record ID" do
      request.headers["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSJ9.IdCz91KkIj7SrjjxYTsCiThSTAmJFysugQ5aLZ7O390"
      expect { delete :destroy, params: { id: 99 } }.to change { Record.count }.by(0)
    end
  end


end