require 'uri'
require 'net/http'

class SpotifyApiService

  CLIENT_ID =  '74e55d3cff04495990229f6311be5d42'
  CLIENT_SECRET = 'fc560b0f942141d88c34d354ec7a9a4b'
  AUTH_URI = 'https://accounts.spotify.com/api/token'

  def initialize(client_id = CLIENT_ID, client_secret = CLIENT_SECRET)
    @client_id = client_id
    @client_secret = client_secret 
    @auth_token = ''
    @auth_token_expired = true
  end 

  def search(query)
    ##send API call for search query
  end

  def self.call(record_title)
    authorize

    "Api call for " + record_title + " successful" 
  end

  private

  def self.authorize
    http = Net::HTTP.new("localhost", "3000")
    uri = URI(AUTH_URI)
    encrypted_client_info = Base64.strict_encode64("#{CLIENT_ID}:#{CLIENT_SECRET}")
    

    body = { "grant_type": "client_credientials" }

    request = Net::HTTP::Post.new(uri)
    # set header
    request["Authorization"] = "Basic#{encrypted_client_info}"
    request.body = body
    result = http.request(request)

    binding.pry
    # puts res.body if res.is_a?(Net::HTTPSuccess)
  end



end
