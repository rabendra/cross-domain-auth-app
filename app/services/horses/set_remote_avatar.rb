module Horses
  class SetRemoteAvatar < BaseService
    def perform(horse, resource_key)
      url = Uploads::FetchURLFromResourceKey.perform(resource_key)

      horse.remote_photo_url = url
    end
  end
end
