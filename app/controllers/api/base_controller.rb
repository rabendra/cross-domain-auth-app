class Api::BaseController < ApplicationController
  protected

    def authenticate_request!
      @current_user = authenticate_user_from_jwt
      render json: { errors: "Invalid auth token" }, status: :bad_request unless @current_user
    end

    def authenticate_user_from_jwt 
      begin          
        token = params['authorization']
        decoded_token = AuthenticationToken.decode(token)
        User.find_by( id: decoded_token[:user_id])
      rescue Exception => e
      end
    end
end
