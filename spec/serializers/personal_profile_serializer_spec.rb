require 'rails_helper'

RSpec.describe PersonalProfileSerializer, type: :serializer do
  let(:user) { build(:user, :personal) }
  let(:resource) { user.profile }

  include ProfileSerializerSharedExamples

  it { is_expected.to include(first_name: resource.first_name) }
  it { is_expected.to include(last_name: resource.last_name) }
end
