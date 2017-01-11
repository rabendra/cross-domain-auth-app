module Users
  class CreateInvitationJob < ApplicationJob
    queue_as :invitations

    rescue_from(ActiveRecord::RecordInvalid) do |e|
      Rails.logger.debug("Inviting duplicate user [ #{ e.record.attributes }]: #{ e.record.errors.full_messages }")
    end

    def perform(requestor, attributes)
      invite = Invitation.create!(attributes) do |invite|
        invite.requestor = requestor
      end

      UserInvitationMailer.invite(invite).deliver_later
    end
  end
end
