class BusinessProfile < Profile
  PROFILE_TYPES = ['reseller'].freeze

  enum profile_type: PROFILE_TYPES

  def name
    first_name
  end
end
