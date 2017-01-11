class HorseSerializer < ActiveModel < Serializer
  attributes :name,
             :age,
             :breed,
             :competition_type

end