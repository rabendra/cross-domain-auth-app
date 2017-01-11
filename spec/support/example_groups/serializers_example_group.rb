module SerializerExampleGroup
  extend ActiveSupport::Concern

  included do
    metadata[:type] = :serializer

    let(:attributes) {}

    let(:resource_name) do
      described_class.name.underscore[0..-12].to_sym
    end

    let(:default_resource) do
      double(resource_name, attributes).tap do |double|
        allow(double).to receive(:read_attribute_for_serialization) do |name|
          attributes[name]
        end
      end
    end

    let(:serializer) { described_class.new((try(:resource) || default_resource), scope: try(:serializer_scope)) }

    subject { serializer.serializable_hash.with_indifferent_access }
  end

  RSpec.configure do |config|
    config.include self, type: :serializer, file_path: %r(spec/serializers)
  end
end
