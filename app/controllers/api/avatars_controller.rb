module API
  class AvatarsController < BaseController
    def update
      Users::SetRemoteAvatar.perform(current_user, params[:resource_key])
      profile.save!

      render json: profile, serializer: profile.serializer_class
    end

    private

    def profile
      @profile ||= current_user.profile
    end
  end
end
