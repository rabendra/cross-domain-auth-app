require 'rails_helper'

RSpec.describe API::Horses::PhotosController, type: :controller do
  let(:horse) { create(:horse) }
  let(:user)  { horse.user }

  describe 'PUT photo' do
    it 'responds with a 200' do
      send_request

      expect(response.code).to eq('200')
    end

    it 'responds with a serialized Horse' do
      send_request

      attributes = attributes_from(HorseSerializer.new(horse.reload))
      json = JSON.parse(response.body).with_indifferent_access

      expect(attributes).to eq(json)
    end

    it 'downloads the file from our internal S3 bucket and saves' do
      expect { send_request }.to change { horse.reload.photo }
    end

    def send_request
      set_http_headers(user)

      VCR.use_cassette 'horses/photo' do
        put :update, params: { horse_id: horse.id, resource_key: 'cat.jpg' }
      end
    end
  end
end
