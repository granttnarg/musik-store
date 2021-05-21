class AuthenticationTokenService
  HMAC_SECRET = "s3rcr3tk3y"
  ALGORITHYM_TYPE = "HS256"

  def self.call(user_id)
    payload = { user_id: user_id }
    
    JWT.encode payload, HMAC_SECRET, ALGORITHYM_TYPE
  end

end