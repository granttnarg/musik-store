require 'uri'
# require 'net/http'
require 'httparty'

class SpotifyApiService
  attr_reader :access_token

  CLIENT_ID =  '74e55d3cff04495990229f6311be5d42'
  CLIENT_SECRET = 'fc560b0f942141d88c34d354ec7a9a4b'
  AUTH_URI = 'https://accounts.spotify.com/api/token'

  def initialize(client_id = CLIENT_ID, client_secret = CLIENT_SECRET)
    @client_id = client_id
    @client_secret = client_secret 
    @access_token = nil
    @token_expire_time = nil
    @access_token_expired = true
    @query = nil
  end 

  def search(query)
    ##send API call for search query
  end

  def authorize
    response = HTTParty.post(AUTH_URI,
              :body =>  "grant_type=client_credentials",
              :headers => {"Authorization" => "Basic #{encrypt_credentials(@client_id, @client_secret)}" }
    )
    return false if response["access_token"].nil? && response["token_type"].nil? && response["expires_in"].nil?
    store_auth_token(response)
    true
  end 

  def store_auth_token(response)
    if @access_token_expired
      @access_token = response["access_token"]
      expiry = Time.now + response["expires_in"].to_i 
      @access_token_expired = expiry <= Time.now
    end
  end

  def search_request(query)
    query_string = URI.encode_www_form({q: query, type: "track"})
    search_uri = "https://api.spotify.com/v1/search?#{query_string}"
    response = HTTParty.get(search_uri,
              :headers => {"Authorization" => "Bearer #{@access_token}" }
    )
  end

  def reccomendation_request(seed_artists, seed_genres, seed_tracks, limit)
    query_string = URI.encode_www_form({ seed_artists: seed_artists, seed_genres: seed_genres, seed_tracks: seed_tracks, limit: limit })
    search_uri = "https://api.spotify.com/v1/recommendations?#{query_string}"
    response = HTTParty.get(search_uri,
              :headers => {"Authorization" => "Bearer #{@access_token}" }
    )
  end

  private

  def encrypt_credentials(id, secret)
    Base64.strict_encode64("#{id}:#{secret}")
  end

end
