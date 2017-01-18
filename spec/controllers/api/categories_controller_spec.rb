require 'rails_helper'

RSpec.describe API::CategoriesController, type: :controller do
  before(:each) do
    @category = FactoryGirl.create(:category)
    @user = FactoryGirl.create(:user)
    set_http_headers(@user)
  end

  describe 'POST create' do
    it 'responds with 200' do
      send_request
      expect(response.code).to eq('200')
    end

  def send_request
      post :create, category: @category
  end
  def token_for_user(user)
    AuthenticationToken.encode(user.token_payload)
  end

  def http_auth_headers(user)
    { 'Authorization' => token_for_user(user) }
  end

  def set_http_headers(user)
    @request.headers.merge!(http_auth_headers(user))
  end
end
end