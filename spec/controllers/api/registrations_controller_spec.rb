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

  describe 'POST authenticate' do
    it 'responds with 200'
    send_facebook_request

    expect(response.code).to eq('200')
  end
  #
  # it 'creates a User from authentication token' do
  #
  # end
  #
  # it 'responds with user_token' do
  #
  # end
  #
  def send_facebook_request
    authentication_token = 'EAAKWWLvpFCUBAJrvURL4Kdscm6xeQla6DI4EhM8LWUpnttQTySz2vq3DfJFZBOlnW5iZBg1swihRRmUowzo7TfMyarDlwVbk2XG2SWpXZBUb4QrbOrBMjUZCDdeirLfKzwbHIzesYm6yS7toApoas5qODlyZCwJ6VilsphKyodZAQmlQtrtsw2fwx0c2NRR6fZCV7e257NClvBjO34IbqiK'

    facebook_params = {
        provider_id: nil,
        provider: 'facebook',
        username: nil,
        authenitication_token: authentication_token,
        email: 'fake_email@email.com'
    }
    post :authenticate, params: { provider: 'facebook', authentication_token: authentication_token }
  end

end
