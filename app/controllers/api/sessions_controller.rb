
module API
  class SessionsController < Devise::SessionsController
    include ErrorHandling
    include ForgeryProtection

    def create
      user = User.find_by(email: sign_in_params[:email])
      if user && user.valid_password?(sign_in_params[:password])
        user.user_token = AuthenticationToken.encode(user.token_payload)
        render json: {id: user.id, accessToken: user.user_token, created_at: user.created_at, updated_at: user.updated_at, username: user.username}
        # render json: user, serializer: LoginSerializer
      else
        raise UnprocessableEntityError, 'Invalid username or password'
      end
    end

    private

    def sign_in_params
      params.require(:user).permit(:email, :password)
    end
  end
end
