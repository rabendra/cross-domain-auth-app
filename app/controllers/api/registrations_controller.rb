class API::RegistrationsController < Devise::RegistrationsController
  include API::ForgeryProtection
  include API::ErrorHandling
  def create
    params.permit!
    user = User.create!(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if user.valid?
      return_auth_token user
    end
  end

  def authentication
     user = User.where(:provider_id => params[:auth][:extra][:raw_info][:id]).first
    if user
      return return_auth_token user
    else
      user = User.create!(provider_id:params[:auth][:extra][:raw_info][:id],
                                        provider:params[:auth][:provider],
                                        username:params[:auth][:extra][:raw_info][:name].delete(' '),
                                        authentication_token:params[:auth][:credentials][:token],
                                        email:params[:auth][:extra][:raw_info][:email],
                                        password:Devise.friendly_token[0,20])

      if user.valid?
        retrun_auth_token user
      end
    end
  end

  private

  def return_auth_token(user)
    user.user_token =  AuthenticationToken.encode(user.token_payload)
    render json: user, serializer: UserSerializer, status: :ok    
  end

end
