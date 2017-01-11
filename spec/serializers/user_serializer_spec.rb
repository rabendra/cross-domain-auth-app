require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer do
  let(:resource) { create(:user) }

  it { is_expected.to include(id: resource.id) }
  it { is_expected.to include(email: resource.email) }
end
