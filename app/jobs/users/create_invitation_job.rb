module Users
  class CreateInvitationJob < ApplicationJob
    queue_as :invitations

    def perform(requestor, attributes)
      invite = Invitation.create!(attributes) do |invite|
        invite.requestor = requestor
      end

      UserInvitationMailer.invite(invite).deliver_later
    end
  end
end
