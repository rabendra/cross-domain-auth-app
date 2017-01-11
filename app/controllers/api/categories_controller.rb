class Api::CategoriesController < Api::BaseController
  def create
    begin
      category = @current_user.categories.create(category_params)
      if category.valid?
        retrun_category_response category
      else
        return_error category.errors.messages
      end
    rescue Exception => e
      return_error "#{e.class}"
    end
  end

  def category_params
    params
      .require(:category)
      .permit(
        :name
      )
  end

  def retrun_category_response(category)
    render json: category, serializer: CategorySerializer, status: :ok    
  end

  def return_error(errors)
    render json: { errors: errors }, status: :bad_request
    return
  end

end