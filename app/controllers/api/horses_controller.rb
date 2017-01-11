module API
  class HorsesController < BaseController

    def create
      horse = current_user.horses.create!(horse_params)

      render json: horse, serializer: HorseSerializer, status: :created
    end

    private

    def horse_params
      params.permit(:name, :age, :breed, :competition_type)
    end
  end
end
