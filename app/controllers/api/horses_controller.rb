module API
  class HorsesController < BaseController

    def index
      render json: current_user.horses, each_serializer: HorseSerializer
    end

    def create
      horse = current_user.horses.create!(horse_params)

      render json: horse, serializer: HorseSerializer, status: :created
    end

    def show
      render json: horse, serializer: HorseSerializer
    end

    def update
      horse.update!(horse_params)

      render json: horse, serializer: HorseSerializer
    end

    def destroy
      horse.destroy!

      head :no_content
    end

    private

    def horse
      @horse ||= current_user.horses.find(params[:id])
    end

    def horse_params
      params.permit(:name, :age, :breed, :competition_type)
    end
  end
end

