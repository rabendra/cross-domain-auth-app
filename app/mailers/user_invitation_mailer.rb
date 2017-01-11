class UserInvitationMailer < ApplicationMailer
  def invite(invitation)
    @invitation = invitation

    mail to: invitation.email, subject: default_i18n_subject(name: invitation.requestor.name)
  end
end
