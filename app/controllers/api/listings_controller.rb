module API
  class ListingsController < BaseController

    before_action :get_category

    def create
      listing = @current_user.listings.new(item_name: params[:item_name], location: params[:location], description: params[:description], price: params[:price])
      listing.tag_list = params[:tags] if !params[:tags].blank?
      if !get_category.nil?
        listing.categories_listings.new( category_id: get_category.id )
        if listing.save
          retrun_listing_response listing
        end
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def show
      listing = Listing.find_by(id: params[:id])
      if listing
        retrun_listing_response listing
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def index
      listings = @current_user.listings
      if listings
        retrun_all_listing_response listings
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def search
      key = "%#{params[:search]}%"
      listings = Listing.where('item_name LIKE :search OR location LIKE :search OR description LIKE :search', search: key).paginate(:page => params[:page], :per_page => params[:per_page])
      if listings
        retrun_all_listing_response listings
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def meta
      tags = ActsAsTaggableOn::Tag.all
      categories = Category.all
      if tags
        retrun_meta_response categories, tags
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def retrun_all_listing_response(listings)
      render json: listings, adapter: :json, each_serializer: ListingSerializer, :meta => {
      page: listings.current_page,
      total: listings.count
    }, status: :ok
    end


    def retrun_listing_response(listing)
      respond_with listing, serializer: ListingSerializer, status: :ok
    end

    def retrun_meta_response(*args)
      render :json => {"total_num_active": Category.all.count+ActsAsTaggableOn::Tag.all.count,
          "total_num_active_categories": Category.all.count, "total_num_active_tags": ActsAsTaggableOn::Tag.all.count,
          categories: args[0].as_json(:only => [:id, :name]),
          tags: args[1].as_json(:only => [:name]),
      }, status: :ok
    end

    def get_category
      Category.find_by(id: params[:categories_id] )
    end

    def retrun_category_all_response(categories)
      render json: categories, each_serializer: CategorySerializer, status: :ok
    end

  end
end
