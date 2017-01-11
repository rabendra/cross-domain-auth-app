module API
  module Authorization
    extend ActiveSupport::Concern

    included do
      before_action :ensure_user_authenticated!, if: :authentication_required?
    end

    def current_user
      @current_user ||= User.find_by(id: authorization_token[:user_id])
    end

    private

    def authentication_required?
      true
    end

    def ensure_user_authenticated!
      return if current_user.present?

      raise AuthenticationRequired, 'You must be authorized to perform this action.'
    end

    def authorization_token_string
      @authorization_token_string ||= request.headers['Authorization'] || raise(AuthenticationRequired, 'Must provide a JWT token')
    end

    def authorization_token
      @authorization_token ||= AuthenticationToken.decode(authorization_token_string)
    end
  end
end
