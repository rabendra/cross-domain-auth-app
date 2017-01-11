require 'rails_helper'

RSpec.describe Users::CreateInvitationJob, type: :job do
  let(:requestor) { create(:user, :personal) }
  let(:params) do
    {
      first_name: 'Susie',
      last_name: 'Sue',
      email: 'susie.sue@gmail.com'
    }
  end

  it 'creates the invitation instance' do
    expect { subject.perform(requestor, params) }.to change(Users::Invitation, :count).by(1)
  end

  it 'enqueues an email notification' do
    subject.perform(requestor, params)

    expect(ActionMailer::DeliveryJob).to have_been_enqueued.with(UserInvitationMailer.name, 'invite', 'deliver_now', Users::Invitation.last)
  end
end
