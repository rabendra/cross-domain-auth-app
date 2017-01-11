require 'rails_helper'

RSpec.describe API::HorsesController, type: :controller do
  let(:user) { create(:user, :business) }

  describe 'POST create' do
    let(:params) { attributes_for(:horse) }

    it 'responds with 201' do
      send_request

      expect(response.code).to eq('201')
    end

    it 'creates the horse' do
      expect { send_request }.to change { user.horses.count }.by(1)
    end

    it 'responds with horse JSON' do
      send_request
      
      attributes = attributes_from(HorseSerializer.new(user.horses.last))
      json = JSON.parse(response.body).with_indifferent_access

      expect(attributes).to eq(json)
    end

    def send_request
      set_http_headers(user)

      post :create, params: params
    end
  end
end
