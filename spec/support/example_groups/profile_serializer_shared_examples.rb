module ProfileSerializerSharedExamples
  extend ActiveSupport::Concern

  included do
    it { is_expected.to include(id: user.id) }
    it { is_expected.to include(email: user.email) }
    it { is_expected.to include(bio: resource.bio) }
    it { is_expected.to include(birth_date: resource.birth_date.iso8601) }
    it { is_expected.to include(avatar: resource.avatar.url) }
    it { is_expected.to include(profile_type: resource.profile_type) }
  end
end
