class Api::HorsesController < Api::BaseController
  def create
    begin
      horse = @current_user.horses.create(horse_params)
      if horse.valid?
        retrun_horse_response horse
      else
        return_error horse.errors.messages
      end
    rescue Exception => e
      return_error "#{e.class}"
    end
  end

  def horse_params
    params
      .require(:horse)
      .permit(
        :user_id,
        :name,
        :age,
        :competition_type,
        :breed,
        :photo
      )
  end

  def retrun_horse_response(horse)
    render json: horse, serializer: HorseSerializer, status: :ok    
  end

  def return_error(errors)
    render json: { errors: errors }, status: :bad_request
    return
  end

end