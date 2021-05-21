class AuthenticationTokenService
  HMAC_SECRET = "s3rcr3tk3y"
  ALGORITHYM_TYPE = "HS256"

  def self.call
    payload = { "test" => "testing" }
    
    JWT.encode payload, HMAC_SECRET, ALGORITHYM_TYPE
  end

end