class Api::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery unless: -> { request.format.json? }
  respond_to :json
  def create
    begin
      user = User.create(sign_up_params)
      if user.valid?
        return_auth_token user
      else
        return_error user.errors.messages
      end
    rescue Exception => e
      return_error "#{e.class}"
    end
  end

  def authentication     
     user = User.where(:provider_id => params[:user][:auth][:extra][:raw_info][:id]).first
    if user
      return retrun_auth_token user
    else
      begin
        user = User.create(provider_id:params[:user][:auth][:extra][:raw_info][:id],
                                        provider:params[:user][:auth][:provider],
                                        username:params[:user][:auth][:extra][:raw_info][:name].delete(' '),
                                        authentication_token:params[:user][:auth][:credentials][:token],
                                        email:params[:user][:auth][:extra][:raw_info][:email],
                                        password:Devise.friendly_token[0,20])

        if user.valid?
          retrun_auth_token user
        else
          return_error user.errors.messages
        end
      rescue Exception => e
        return_error "#{e.class}"
      end
    end
  end

  private

  def sign_up_params
    params
      .require(:user)
      .permit(
        :username,
        :email,
        :password,
        :password_confirmation,
        :auth
      )
  end

  def return_auth_token(user)
    user.user_token =  AuthenticationToken.encode(user.token_payload)
    render json: user, serializer: UserSerializer, status: :ok    
  end

  def return_error(errors)
    render json: { errors: errors }, status: :bad_request
    return
  end

end
