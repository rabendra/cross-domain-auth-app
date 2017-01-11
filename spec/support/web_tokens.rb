module WebTokens
  def token_for_user(user)
    AuthenticationToken.encode(user.token_payload)
  end

  def http_auth_headers(user)
    { 'Authorization' => token_for_user(user) }
  end

  def set_http_headers(user)
    @request.headers.merge!(http_auth_headers(user))
  end
end

RSpec.configure do |config|
  config.include WebTokens, type: :controller
end
