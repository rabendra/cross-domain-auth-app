class RegistrationSerializer < ActiveModel::Serializer
  attributes :user_token
             # :type,
             # :avatar
  #TODO type, avatar, and profile need to be added, but how do we know this upon initial registration?

end