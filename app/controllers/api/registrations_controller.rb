module API
  class RegistrationsController < Devise::RegistrationsController
    include ErrorHandling
    include ForgeryProtection

    #CREATE WITH EMAIL
    def create
      debugger
      user = User.create!(sign_up_params)
      user.user_token = AuthenticationToken.encode(user.token_payload)
      render json: user, serializer: RegistrationSerializer
    end

    #CREATE/LOGIN WITH FACEBOOOK
    def authenticate
      user = User.where(:provider_id => params[:user][:auth][:extra][:raw_info][:id]).first
      if user
        encode_and_return_token_json user
      else
          user = User.create(provider_id:params[:user][:auth][:extra][:raw_info][:id],
                             provider:params[:user][:auth][:provider],
                             username:params[:user][:auth][:extra][:raw_info][:name].delete(' '),
                             authentication_token:params[:user][:auth][:credentials][:token],
                             email:params[:user][:auth][:extra][:raw_info][:email],
                             password:Devise.friendly_token[0,20])
          if user.valid?
            encode_and_return_token_json user
          end
        end
    end

    private
    def encode_and_return_token_json(user)
      user.user_token = AuthenticationToken.encode(user.token_payload)
      render json: user, serializer: RegistrationSerializer
    end

    def sign_up_params
      params.permit(:email, :password, :password_confirmation,:phone_number)
    end
  end
end
