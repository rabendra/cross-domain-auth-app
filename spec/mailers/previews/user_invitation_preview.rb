# Preview all emails at http://localhost:3000/rails/mailers/user_invitation
class UserInvitationPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_invitation/invite
  def invite
    invitation = Users::Invitation.create!(requestor: User.first, email: 'test@gmail.com', first_name: 'Johnny', last_name: 'Appleseed')

    UserInvitationMailer.invite(invitation)
  end
end
