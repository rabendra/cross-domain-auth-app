require 'rails_helper'

RSpec.describe Horses::SetRemoteAvatar, type: :service do
  let(:horse) { create(:horse) }

  it 'sets the remote URL for the profile' do
    allow_any_instance_of(Uploads::FetchURLFromResourceKey).to receive(:perform).and_return('url://picture.jpg')

    expect(horse).to receive(:remote_photo_url=).with('url://picture.jpg')

    subject.perform(horse, 'picture.jpg')
  end
end
