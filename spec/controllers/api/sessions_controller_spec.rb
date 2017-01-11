require 'rails_helper'

RSpec.describe API::SessionsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'POST create' do
    context 'when email and password are correct' do
      let(:user) { create(:user) }

      before do
        post :create, params: { email: user.email, password: 'password' }
      end

      it 'responds with 200' do
        expect(response).to be_ok
      end

      it 'renders JSON using the serializer' do
        attributes = attributes_from(UserSerializer.new(user)).except(:user_token)
        json = JSON.parse(response.body).with_indifferent_access.except(:user_token)

        expect(json).to eq(attributes)
      end
    end

    context 'when email and password are wrong' do
      before do
        post :create, params: { email: 'dummy', password: nil }
      end

      let(:json) { JSON.parse(response.body).with_indifferent_access }

      it 'responds with 422' do
        expect(response.code).to eq('422')
      end

      it 'provides a message' do
        expect(json).to include(message: 'Invalid username or password')
      end
    end
  end
end
