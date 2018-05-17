class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  attr_accessor :user_token

  def token_payload
    {
      user_id: id,
      email: email,
      username: username
    }
  end

  def self.user_create_by_provider(*args)
    case args[0]
    when 'facebook'
      fb_user = FacebookApi.find_user(args[1])
      user = User.create!(provider: args[0], provider_id: fb_user["id"], username: fb_user["name"], authentication_token: args[1], password: Devise.friendly_token[0,20], image_url: args[2], email: (args[3] || "test@mail.com"))
    when 'google'
      google_user = GoogleApi.find_user(args[1])
      user = User.create!(provider: args[0], provider_id: google_user["id"], email:  google_user["emails"][0]["value"], username: google_user["displayName"], image_url: google_user["image"]["url"], authentication_token: args[1], password: Devise.friendly_token[0,20] )
    end
    return user
  end

end
