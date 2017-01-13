class HorseSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :age,
             :photo,
             :breed,
             :competition_type


  def photo
    object.photo.url
  end
end
