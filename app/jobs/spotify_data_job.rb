class SpotifyDataJob < ApplicationJob
  queue_as :default

  def perform(record_title)
    ## Simulate background api call to spotify API
    sleep 10
    "Api call for " + record_title + " successful" 
    # uri = URI('http://localhost:4567/update_sku')
    # req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    # req.body = {sku: '123', title: record_title}.to_json
    # res = Net::HTTP.start(uri.hostname, uri.port) do |http|
    #   http.request(req)
    #  end
  end
end
