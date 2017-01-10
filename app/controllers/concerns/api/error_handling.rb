module API
  UnprocessableEntityError = Class.new(StandardError)

  module ErrorHandling
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound do |e|
        render json: e, serializer: ExceptionSerializer, status: :not_found
      end

      rescue_from UnprocessableEntityError do |e|
        render json: e, serializer: ExceptionSerializer, status: :unprocessable_entity
      end

      rescue_from StandardError do |e|
        render json: e, serializer: ExceptionSerializer, status: :bad_request
      end
    end
  end
end
