require 'rails_helper'

RSpec.describe SpotifyDataJob, type: :job do
  let(:record_name) {'Hit Record'}
  it 'calls api with correct params' do
    #come back to expand this when service is set up
    expect(described_class.perform_now(record_name)).to eq("Api call for Hit Record successful" )
  end
end
