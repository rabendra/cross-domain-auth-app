class Api::ListingsController < Api::BaseController

  before_action :get_category

  def create
    begin
      listing = @current_user.listings.new(listing_params)
      listing.tag_list = params[:tags] if !params[:tags].blank?    
      listing.categories_listings.new( category_id: get_category.id )      
      if listing.save
        retrun_listing_response listing
      else
        return_error listing.errors.messages
      end
    rescue Exception => e
      return_error "#{e.class}"
    end
  end

  def listing_params
    params
      .require(:listing)
      .permit(
        :item_name,
        :location,
        :description,
        :price
      )
  end

  def retrun_listing_response(listing)
    render json: listing, serializer: ListingSerializer, status: :ok    
  end

  def return_error(errors)
    render json: { errors: errors }, status: :bad_request
    return
  end

  def get_category
    Category.find_by(id: params[:categories_id] )
  end
end