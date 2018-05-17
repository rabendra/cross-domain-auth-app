require 'rest-client'
class GoogleApi
  def self.find_user(oauth_access_token)
    response = JSON.parse RestClient.get "https://www.googleapis.com/plus/v1/people/me?access_token=#{oauth_access_token}"
    return response
  end
end
