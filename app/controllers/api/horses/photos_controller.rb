module API; module Horses
  class PhotosController < BaseController
    def update
      ::Horses::SetRemoteAvatar.perform(horse, params[:resource_key])
      horse.save!

      render json: horse, serializer: HorseSerializer
    end

    private

    def horse
      @horse ||= current_user.horses.find(params[:horse_id])
    end
  end
end; end
