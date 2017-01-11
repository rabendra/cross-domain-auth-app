module API
  class HorsesController < BaseController
    include Authorization
    include ErrorHandling

    #TODO understand authentication layer
    #TODO understand error handling

    def create
      begin
        horse = @current_user.horses.create(horse_params)
        if horse.valid?
          return_horse_response horse
        else
          return_error horse.errors.messages
        end
      rescue Exception => e
        return_error "#{e.class}"
      end
    end

    private
    def horse_params
      params.permit(:name, :age, :breed, :competition_type)
    end

    def return_horse_response(horse)
      render json: horse, serializer: HorseSerializer, status: :ok
    end

    def return_error(errors)
      render json: { errors: errors }, status: :bad_request
      return
    end

  end
end