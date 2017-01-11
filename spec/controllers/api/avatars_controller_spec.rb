require 'rails_helper'

RSpec.describe API::AvatarsController, type: :controller do
  let(:user) { create(:user, :business) }

  it 'downloads the file from our internal S3 bucket and saves' do
    skip
  end
end
