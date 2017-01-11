require 'rails_helper'

RSpec.describe API::PersonalProfilesController, type: :controller do
  context 'for a new profile' do
    let(:user) { create(:user) }
    let(:params) do
      attributes_for(:personal_profile).merge(address_attributes: attributes_for(:address))
    end

    describe 'PUT update' do
      it 'returns a 200' do
        send_request

        expect(response.code).to eq('200')
      end

      it 'renders the profile JSON' do
        send_request

        json = JSON.parse(response.body).with_indifferent_access
        serialized_profile = attributes_from(PersonalProfileSerializer.new(user.reload.profile))

        expect(json).to eq(serialized_profile)
      end

      def send_request
        set_http_headers(user)

        put :update, params: params.merge(user_id: user.id)
      end
    end
  end

  context 'for an existing profile' do
    let(:user) { create(:user, :personal) }
    let(:profile) { user.profile }
  end
end
