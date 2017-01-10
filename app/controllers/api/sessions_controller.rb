class API::SessionsController < Devise::SessionsController
  include API::ErrorHandling
  include API::ForgeryProtection

  InvalidUsernameOrPassword = Class.new(StandardError)

  def create
    user = User.find_by_email(sign_in_params[:email])

    if user && user.valid_password?(sign_in_params[:password])
      user.user_token = AuthenticationToken.encode(user.token_payload)
      render json: user, serializer: UserSerializer, status: :ok
    else
      raise InvalidUsernameOrPassword, 'Invalid username or passord'
    end
  end

  def sign_in_params
    params
        .require(:user)
        .permit(
            :email,
            :password
        )
  end
end
