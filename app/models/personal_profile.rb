class PersonalProfile < Profile
  PROFILE_TYPES = ['rider', 'trainer'].freeze

  enum profile_type: PROFILE_TYPES

  def name
    [ first_name, last_name ].join(' ')
  end

  def serializer_class
    PersonalProfileSerializer
  end
end
