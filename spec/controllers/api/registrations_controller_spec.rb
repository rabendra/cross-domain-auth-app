require 'rails_helper'

RSpec.describe API::RegistrationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    @user_attr = FactoryGirl.attributes_for :user
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST create' do

    it 'responds with 200' do
      send_request

      expect(response.code).to eq('200')
    end

    it 'creates a user' do
      expect { send_request }.to change { User.count }
    end

    it 'responds with user_token' do
      send_request

      json = JSON.parse(response.body).with_indifferent_access
      expect(json).to include(api_key: kind_of(String))
    end

    def send_request
      post :create, params: @user_attr.slice(:email, :password)
    end
  end


  describe 'POST authenticate' do

    it 'responds with 200' do
      create_test_user
      send_auth(@user1)

      expect(response.code).to eq('200')
    end

    it 'creates a User from authentication token' do
      create_test_user
      expect { send_auth(@user2) }.to change { User.count }
    end

    it 'responds with user_token' do
      create_test_user
      send_auth(@user2)

      json = JSON.parse(response.body).with_indifferent_access
      expect(json).to include(user_token: kind_of(String))
    end

    def create_test_user
      test_users = Koala::Facebook::TestUsers.new(:app_id => ENV['FACEBOOK_ID'], :secret => ENV['FACEBOOK_SECRET'])
      @user1 = test_users.create(true)
      @user2 = test_users.create(true)
      # @user3 = test_users.create(true)
    end

    def send_auth(user)
      params = {}
              params[:email] = user["email"]
              params[:provider] = 'facebook'
              params[:uid] = user["id"]
              params[:oauth_token] = user["access_token"]

          post :authenticate, params: params
    end
  end
end
