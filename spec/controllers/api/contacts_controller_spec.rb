require 'rails_helper'

RSpec.describe API::ContactsController, type: :controller do
  let(:user) { create(:user, :personal) }

  describe 'POST create' do
    let(:contact_attributes) do
      {
        first_name: 'Susie',
        last_name: 'Sue',
        email: 'susie@gmail.com'
      }
    end

    it 'returns a 204 response' do
      send_request

      expect(response.code).to eq('204')
    end

    it 'creates the invitations' do
      send_request

      expect(Users::CreateInvitationJob).to have_been_enqueued.with(user, contact_attributes.with_indifferent_access)
    end

    def send_request
      set_http_headers(user)

      post :create, params: { contacts: [contact_attributes] }
    end
  end
end
