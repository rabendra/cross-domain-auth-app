class HorseSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :age,
             :breed,
             :competition_type

end
