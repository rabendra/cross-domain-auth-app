module API
  class PersonalProfilesController < BaseController
    def update
      profile.save!

      render json: profile, serializer: PersonalProfileSerializer
    end

    private

    def profile
      @profile ||= build_profile
    end

    def build_profile
      # user.profile.where(type: PersonalProfile.name).first_or_initialize
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
