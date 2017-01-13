class AddressSerializer < ActiveModel::Serializer
  attributes :street, :street_2, :city, :state, :zip_code, :country, :latitude, :longitude
end
