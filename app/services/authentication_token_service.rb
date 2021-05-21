class AuthenticationTokenService
  HMAC_SECRET = "s3rcr3tk3y"
  ALGORITHYM_TYPE = "HS256"

  def self.call(user_id)
    payload = { user_id: user_id }
    
    JWT.encode payload, HMAC_SECRET, ALGORITHYM_TYPE
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, HMAC_SECRET, true, { algorithm: ALGORITHYM_TYPE })
    user_id = decoded_token[0]['user_id']
  end

end