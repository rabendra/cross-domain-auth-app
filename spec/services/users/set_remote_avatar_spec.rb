require 'rails_helper'

RSpec.describe Users::SetRemoteAvatar, type: :service do
  let(:user) { create(:user, :business) }

  it 'sets the remote URL for the profile' do
    allow_any_instance_of(Uploads::FetchURLFromResourceKey).to receive(:perform).and_return('url://picture.jpg')

    expect(user.profile).to receive(:remote_avatar_url=).with('url://picture.jpg')

    subject.perform(user, 'picture.jpg')
  end
end
