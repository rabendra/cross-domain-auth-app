require 'rails_helper'

RSpec.describe Users::Invitation, type: :model do
  it { is_expected.to belong_to(:requestor).class_name(User.name) }
  it { is_expected.to validate_presence_of(:requestor).with_message('must exist') }

  it { is_expected.to validate_presence_of(:email) }

  describe '.name' do
    subject { invitation.name }

    context 'with name' do
      let(:invitation) { build(:users_invitation, last_name: nil) }

      it { is_expected.to eq(invitation.first_name) }
    end

    context 'with only an email' do
      let(:invitation) { build(:users_invitation, first_name: nil, last_name: nil) }

      it { is_expected.to eq(invitation.email) }
    end
  end

  describe 'uniqueness' do
    let(:user) { create(:user) }
    subject { build(:users_invitation, requestor: user, email: user.email) }

    it { is_expected.not_to be_valid }

    it 'has an error on the email attribute' do
      subject.valid?

      expect(subject.errors[:email]).to include('This user already exists in the system')
    end
  end
end
