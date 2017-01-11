class ExceptionSerializer < ActiveModel::Serializer
  attributes :class_name, :message
  attribute :errors, if: :validation_errors?

  def message
    object.message
  end

  def class_name
    object.class.name
  end

  def errors
    object.record.errors.full_messages
  end

  def validation_errors?
    object.is_a?(ActiveRecord::RecordInvalid)
  end
end
