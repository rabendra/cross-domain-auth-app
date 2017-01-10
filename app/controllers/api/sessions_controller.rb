class API::SessionsController < Devise::SessionsController
  protect_from_forgery unless: -> { request.format.json? }

  def create
    user = User.find_by_email(sign_in_params[:email])

    if user && user.valid_password?(sign_in_params[:password])
      user.user_token = AuthenticationToken.encode(user.token_payload)
      render json: user, serializer: UserSerializer, status: :ok
    else
      render json: { errors: "Invalid username or password" }, status: :bad_request
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
