require 'rails_helper'

RSpec.describe API::AvatarsController, type: :controller do
  let(:user) { create(:user, :business) }

  before { set_http_headers(user) }

  it 'responds with a 200' do
    VCR.use_cassette 'cognito/cat' do
      put :update, params: { resource_key: 'cat.jpg' }
    end

    expect(response.code).to eq('200')
  end

  it 'responds with a serialized User' do
    VCR.use_cassette 'cognito/cat' do
      put :update, params: { resource_key: 'cat.jpg' }
    end
    
    attributes = attributes_from(UserSerializer.new(user))
    json = JSON.parse(response.body).with_indifferent_access

    expect(json).to eq(attributes)
  end

  it 'downloads the file from our internal S3 bucket and saves' do
    VCR.use_cassette 'cognito/cat' do
      expect do
        put :update, params: { resource_key: 'cat.jpg' }
      end.to change { user.profile.reload.avatar }
    end
  end
end
