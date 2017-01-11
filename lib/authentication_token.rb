class AuthenticationToken
  def self.encode(payload, ttl_in_minutes = 60 * 24)
    payload[:exp] = ttl_in_minutes.minutes.from_now.to_i
    JWT.encode payload, Rails.application.secrets.secret_key_base, 'HS256'
  end

  def self.decode(token, leeway = nil)
    decoded = JWT.decode(

        token,
        Rails.application.secrets.secret_key_base,
        leeway: leeway
    )
    HashWithIndifferentAccess.new(decoded[0])
  end
end