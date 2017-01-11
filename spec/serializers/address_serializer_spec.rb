require 'rails_helper'

RSpec.describe AddressSerializer, type: :serializer do
  let(:resource) { build(:address) }

  it { is_expected.to include(street: resource.street) }
  it { is_expected.to include(street_2: resource.street_2) }
  it { is_expected.to include(city: resource.city) }
  it { is_expected.to include(state: resource.state) }
  it { is_expected.to include(zip_code: resource.zip_code) }
  it { is_expected.to include(country: resource.country) }
  it { is_expected.to include(latitude: resource.latitude) }
  it { is_expected.to include(longitude: resource.longitude) }
end
