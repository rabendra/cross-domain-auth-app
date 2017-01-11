module API
  class AvatarsController < BaseController
    def update
      Users::SetRemoteAvatar.perform(current_user, params[:resource_key])
      current_user.profile.save!

      render json: current_user, serializer: UserSerializer
    end
  end
end
