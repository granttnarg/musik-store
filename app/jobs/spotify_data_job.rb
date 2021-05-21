class SpotifyDataJob < ApplicationJob
  queue_as :default

  def perform(record_title)
    sleep 10
    puts record_title + " saved"
    # uri = URI('http://localhost:4567/update_sku')
    # req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    # req.body = {sku: '123', title: record_title}.to_json
    # res = Net::HTTP.start(uri.hostname, uri.port) do |http|
    #   http.request(req)
    #  end
  end
end
