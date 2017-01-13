require 'rails_helper'

RSpec.describe BusinessProfileSerializer, type: :serializer do
  let(:user) { create(:user, :business) }
  let(:resource) { user.profile }

  include ProfileSerializerSharedExamples

  it { is_expected.to include(name: resource.first_name) }
end
