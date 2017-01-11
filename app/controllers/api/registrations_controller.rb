module API
  class RegistrationsController < Devise::RegistrationsController
    include ErrorHandling
    include ForgeryProtection

    def create
        user = User.create(sign_up_params)
        if user.valid?

          user.user_token = AuthenticationToken.encode(user.token_payload)

          render json: user, serializer: RegistrationSerializer
        else
            raise UnprocessableEntityError, 'Invalid sign up'
        end
    end

  private

    def sign_up_params
      params.permit(:email, :password, :phone_number)
    end

  end
end