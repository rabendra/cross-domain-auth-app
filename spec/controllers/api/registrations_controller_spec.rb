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
      expect(json).to include(user_token: kind_of(String))
    end

    def send_request
      post :create, params: @user_attr.slice(:email, :password)
    end
  end
end
