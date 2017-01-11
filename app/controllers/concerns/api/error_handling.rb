module API
  UnprocessableEntityError = Class.new(StandardError)
  AuthenticationRequired = Class.new(StandardError)

  module ErrorHandling
    extend ActiveSupport::Concern

    included do
      rescue_from StandardError do |e|
        render json: e, serializer: ExceptionSerializer, status: :bad_request
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        render json: e, serializer: ExceptionSerializer, status: :not_found
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        render json: e, serializer: ExceptionSerializer, status: :unprocessable_entity
      end

      rescue_from UnprocessableEntityError do |e|
        render json: e, serializer: ExceptionSerializer, status: :unprocessable_entity
      end

      rescue_from AuthenticationRequired do |e|
        render json: e, serializer: ExceptionSerializer, status: :unauthorized
      end
    end
  end
end
