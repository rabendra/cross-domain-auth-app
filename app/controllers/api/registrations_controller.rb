module API
  class RegistrationsController < Devise::RegistrationsController
    include ErrorHandling
    include ForgeryProtection

    #CREATE WITH EMAIL
    def create
      user = User.create!(sign_up_params)
      user.user_token = AuthenticationToken.encode(user.token_payload)
      render json: user, serializer: RegistrationSerializer
    end

    #CREATE/LOGIN WITH FACEBOOOK
    def authenticate
      validated = validate_facebook_token(resource_params)
      if validated
        user = User.find_by(uid: validated["id"])
        unless user
          user = User.create!(provider: 'facebook',
                              uid: validated["id"],
                              email: resource_params[:email],
                              authentication_token: resource_params[:oauth_token],
                              password: Devise.friendly_token[0,20])
        end
        encode_and_return_token_json user
      end
    end

    private

    def validate_facebook_token(record)
      graph = Koala::Facebook::API.new record[:oauth_token]
      graph.get_object("me")
    end

    def encode_and_return_token_json(user)
      user.user_token = AuthenticationToken.encode(user.token_payload)

      render json: user, serializer: RegistrationSerializer
    end

    def sign_up_params
      params.permit(:email, :password, :phone_number)
    end

    def resource_params
      params.permit(:email, :provider, :uid, :oauth_token)
    end
  end
end
