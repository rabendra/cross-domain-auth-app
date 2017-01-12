class API::HorsesController < Api::BaseController
  def create
    params.permit!
    if !params[:name].blank?
      horse = @current_user.horses.create!(name: params[:name], age: params[:age], competition_type: params[:competition_type], breed: params[:breed], photo: params[:photo])
      if horse.valid?
        retrun_horse_response horse
      else
        return_error horse.errors.messages
      end
    else
      raise StandardError
  end

  def retrun_horse_response(horse)
    render json: horse, serializer: HorseSerializer, status: :ok    
  end

end