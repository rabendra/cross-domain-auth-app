class API::BaseController < ApplicationController
  include API::ErrorHandling

  respond_to :json
end
