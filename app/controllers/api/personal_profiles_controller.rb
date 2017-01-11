module API
  class PersonalProfilesController < BaseController
    def update
      unless profile.is_a?(PersonalProfile)
        raise ArgumentError, 'Cannot switch from business to personal after setup'
      end

      profile.attributes = permitted_params
      profile.save!

      render json: profile, serializer: PersonalProfileSerializer
    end

    private

    def profile
      @profile ||= find_profile || build_profile
    end

    def find_profile
      current_user.profile
    end

    def build_profile
      PersonalProfile.new(permitted_params) do |p|
        p.user = current_user
        p.address = Address.new(address_attributes.merge(addressable: p))
      end
    end

    def permitted_params
      params.permit(:first_name, :last_name, :birth_date, :bio, :profile_type)
    end

    def address_attributes
      params.fetch(:address_attributes, {}).permit(:street, :street_2, :city, :state, :zip_code)
    end
  end
end
