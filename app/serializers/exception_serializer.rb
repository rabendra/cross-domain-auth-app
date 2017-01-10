class ExceptionSerializer < ActiveModel::Serializer
  attributes :class_name, :message

  def message
    object.message
  end

  def class_name
    object.class.name
  end
end
