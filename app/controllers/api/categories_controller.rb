module API
  class CategoriesController < BaseController
    def create
      category = @current_user.categories.create(name: params[:name])
      if category.valid?
        retrun_category_response category
      end
    end

    def index
      categories = Category.all
      if categories
        retrun_category_all_response categories
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def retrun_category_response(category)
      render json: category, serializer: CategorySerializer, status: :ok
    end

    def retrun_category_all_response(categories)
      render json: categories, each_serializer: CategorySerializer, status: :ok
    end

  end
end