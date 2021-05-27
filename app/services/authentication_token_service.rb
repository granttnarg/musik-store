class AuthenticationTokenService
  HMAC_SECRET = "s3rcr3tk3y"
  ALGORITHYM_TYPE = "HS256"

  def self.call(username)
    payload = { username: username }
    JWT.encode payload, HMAC_SECRET, ALGORITHYM_TYPE
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, HMAC_SECRET, true, { algorithm: ALGORITHYM_TYPE })
    username = decoded_token[0]['username']
  end

end