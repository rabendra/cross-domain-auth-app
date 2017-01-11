module API
  class BusinessProfilesController < BaseController
    def update
      profile.attributes = permitted_params
      profile.save!

      render json: profile, serializer: BusinessProfileSerializer
    end

    private

    def profile
      @profile ||= find_profile || build_profile
    end

    def find_profile
      current_user.profile
    end

    def build_profile
      BusinessProfile.new(permitted_params) do |p|
        p.user = current_user
        p.address = Address.new(address_attributes.merge(addressable: p))
      end
    end

    def permitted_params
      params.permit(:name, :birth_date, :bio, :profile_type).tap do |p|
        p[:first_name] = p.delete(:name)
      end
    end

    def address_attributes
      params.fetch(:address_attributes, {}).permit(:street, :street_2, :city, :state, :zip_code)
    end
  end
end
