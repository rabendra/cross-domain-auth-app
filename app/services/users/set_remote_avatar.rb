module Users
  class SetRemoteAvatar < BaseService
    def perform(user, resource_key)
      url = Uploads::FetchURLFromResourceKey.perform(resource_key)

      user.profile.remote_avatar_url = url
    end
  end
end
