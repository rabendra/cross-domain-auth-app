class API::BaseController < ApplicationController
  include API::ForgeryProtection
  include API::ErrorHandling
  include API::Authorization

  respond_to :json
end
