module SerializersSupport
  def attributes_from(serializer_instance)
    serializer_instance.serializable_hash.with_indifferent_access
  end
end

RSpec.configure do |config|
  config.include SerializersSupport, type: :controller
end
