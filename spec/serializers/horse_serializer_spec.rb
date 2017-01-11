require 'rails_helper'

RSpec.describe HorseSerializer, type: :serializer do
  let(:resource) { create(:horse) }

  it { is_expected.to include(id: resource.id) }
  it { is_expected.to include(name: resource.name) }
  it { is_expected.to include(age: resource.age) }
  it { is_expected.to include(breed: resource.breed) }
  it { is_expected.to include(competition_type: resource.competition_type) }
end
