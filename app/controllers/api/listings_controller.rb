class API::ListingsController < Api::BaseController

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

  def retrun_listing_response(listing)
    render json: listing, serializer: ListingSerializer, status: :ok    
  end

  def get_category
    Category.find_by(id: params[:categories_id] )
  end
end