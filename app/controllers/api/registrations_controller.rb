module API
  class RegistrationsController < Devise::RegistrationsController
    include ErrorHandling
    include ForgeryProtection

    #CREATE WITH EMAIL
    def create
        user = User.create!(sign_up_params)
        user.user_token = AuthenticationToken.encode(user.token_payload)
        render json: user, serializer: LoginSerializer
    end

    #CREATE/LOGIN WITH FACEBOOOK
    def auth_with_provider
      if params[:provider] == 'facebook'
        validated = FacebookApi.find_user(params[:oauthAccessToken])
      elsif params[:provider] == 'google' 
        validated = GoogleApi.find_user(params[:oauthAccessToken])
      end
      if validated
        user = User.find_by(provider_id: validated["id"])
        unless user
          user = User.user_create_by_provider(params[:provider], params[:oauthAccessToken], params[:user][:picture][:data][:url], (params[:email]||"test@mail.com")) if params[:provider] == "facebook"
          user = User.user_create_by_provider(params[:provider], params[:oauthAccessToken]) if params[:provider] == "google"
        end
        encode_and_return_token_json user
      end
    end

    private

    def encode_and_return_token_json(user)
      user.user_token = AuthenticationToken.encode(user.token_payload)
      puts "#{user.inspect}"
      render json: user, serializer: LoginSerializer
    end

    def sign_up_params
      params.require(:user).permit(:email, :password, :username)
    end

  end
end
