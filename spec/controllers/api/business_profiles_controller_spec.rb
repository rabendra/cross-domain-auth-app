require 'rails_helper'

RSpec.describe API::BusinessProfilesController, type: :controller do
  context 'for a new profile' do
    let(:user) { create(:user) }
    let(:params) do
      attributes_for(:business_profile).merge(address_attributes: attributes_for(:address)).tap do |attributes|
        attributes[:name] = attributes.delete(:first_name)
      end
    end

    describe 'PUT update' do
      it 'returns a 200' do
        send_request

        expect(response.code).to eq('200')
      end

      it 'creates a profile' do
        expect { send_request }.to change { user.reload.profile }.from(nil).to(kind_of(BusinessProfile))
      end

      it 'renders the profile JSON' do
        send_request

        json = JSON.parse(response.body).with_indifferent_access
        serialized_profile = attributes_from(BusinessProfileSerializer.new(user.reload.profile))

        expect(json).to eq(serialized_profile)
      end

      def send_request
        set_http_headers(user)

        put :update, params: params.merge(user_id: user.id)
      end
    end
  end

  context 'for an existing profile' do
    let(:user) { create(:user, :business) }
    let!(:profile) { user.profile }

    describe 'PUT update' do
      it 'returns a 200' do
        send_request

        expect(response.code).to eq('200')
      end

      it 'renders the profile JSON' do
        send_request

        json = JSON.parse(response.body).with_indifferent_access
        serialized_profile = attributes_from(BusinessProfileSerializer.new(profile.reload))

        expect(json).to eq(serialized_profile)
      end

      it 'updates the business name' do
        expect { send_request }.to change { profile.reload.first_name }.to('Walt')
      end

      def send_request
        set_http_headers(user)

        put :update, params: { user_id: user.id, name: 'Walt' }
      end
    end
  end
end
