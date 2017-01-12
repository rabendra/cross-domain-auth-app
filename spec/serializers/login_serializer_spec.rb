require 'rails_helper'

RSpec.describe LoginSerializer, type: :serializer do
  context 'with a pending profile' do
    let(:resource) { build(:user, :with_token) }

    it { is_expected.to include(type: 'pending') }
    it { is_expected.to include(name: resource.name) }
    it { is_expected.to include(api_key: resource.user_token) }
  end

  context 'with a profile' do
    let(:resource) { build(:user, :personal, :with_token) }

    it { is_expected.to include(type: 'person') }
    it { is_expected.to include(name: resource.name) }
    it { is_expected.to include(api_key: resource.user_token)}
  end
end
