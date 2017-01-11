require "rails_helper"

RSpec.describe UserInvitationMailer, type: :mailer do
  describe "invite" do
    let(:invitation) { build(:users_invitation) }

    let(:mail) { UserInvitationMailer.invite(invitation) }

    it "renders the headers" do
      expect(mail.subject).to eq("#{ invitation.requestor.name } has invited you to join EquusHub!")
      expect(mail.to).to eq([invitation.email])
      expect(mail.from).to eq([ENV['NOTIFICATION_MAILER_ADDRESS']])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("#{ invitation.requestor.name } has invited you to join EquusHub")
    end
  end
end
