require 'rails_helper'
require 'request_helper'

RSpec.describe Api::V1::RecordsController, type: :controller do
  # auth token for username: me ... eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Ik1lIn0.se5D8jyHoEwVnR-t2qivsTzTXFW5QsMgncTrAoenSYM
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
    let!(:artist) { FactoryBot.create(:artist, name: "The Best Band") }
    let(:record_params) { {title: "Another Hit Record", genre: "pop", description: "A great description of a hit record"} }
    
    it 'create a record when an auth token and correct info is sent' do
      request.headers["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Ik1lIn0.se5D8jyHoEwVnR-t2qivsTzTXFW5QsMgncTrAoenSYM"
      expect { post :create, params: {
        artist_id: artist.id ,
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
      request.headers["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Ik1lIn0.se5D8jyHoEwVnR-t2qivsTzTXFW5QsMgncTrAoenSYM"
      expect { delete :destroy,  params: {id: record.id } }.to change { Record.count }.by(-1)
    end

    it "should change Record count with invalid record ID" do
      request.headers["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Ik1lIn0.se5D8jyHoEwVnR-t2qivsTzTXFW5QsMgncTrAoenSYM"
      expect { delete :destroy, params: { id: 99999 } }.to change { Record.count }.by(0)
    end
  end
end