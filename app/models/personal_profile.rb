class PersonalProfile < Profile
  PROFILE_TYPES = ['rider', 'trainer'].freeze

  enum profile_type: PROFILE_TYPES
end
