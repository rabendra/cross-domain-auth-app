class API::CategoriesController < Api::BaseController
  def create
    category = @current_user.categories.create(name: params[:name])
    if category.valid?
      retrun_category_response category
    end
  end

  def retrun_category_response(category)
    render json: category, serializer: CategorySerializer, status: :ok    
  end

end