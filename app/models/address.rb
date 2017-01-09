class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates_presence_of :state, if: ->{ country && country == "US" }

  geocoded_by :full_street_address
  before_save :geocode, if: :geocoding_needed?

  def full_street_address
    return "#{ state }, #{ country }" if street.blank? || city.blank?

    [street, city, state, country].compact.join(', ')
  end

  private

  def geocoding_needed?
    return true if new_record?

    street_changed? ||
      city_changed? ||
      state_changed? ||
      zip_code_changed? ||
      country_changed?
  end
end
