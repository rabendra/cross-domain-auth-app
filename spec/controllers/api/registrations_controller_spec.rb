require 'rails_helper'

RSpec.describe API::RegistrationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    @user_attr = FactoryGirl.attributes_for :user
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end


  describe 'POST create' do

    it 'creates a User with valid data' do
      post :create, params: @user_attr.slice(:email, :password)

      expect(response.code).to eq('200')
    end

  end
end