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

  describe 'GET index' do
    let!(:horse) { create(:horse, user: user) }
    let(:json) { JSON.parse(response.body) }

    it 'responds with 200' do
      send_request

      expect(response.code).to eq('200')
    end

    it 'returns an Array' do
      send_request

      expect(json).to be_an(Array)
    end

    it 'responds with horse JSON' do
      send_request

      attributes = attributes_from(HorseSerializer.new(horse))
      horse_json = json.first.with_indifferent_access

      expect(attributes).to eq(horse_json)
    end

    def send_request
      set_http_headers(user)

      get :index
    end
  end
end
