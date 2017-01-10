module API
  module ErrorHandling
    extend ActiveSupport::Concern

    included do
      rescue_from StandardError do |e|
        render json: e, serializer: ExceptionSerializer, status: :bad_request
      end
    end
  end
end
