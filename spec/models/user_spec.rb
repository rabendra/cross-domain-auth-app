require 'rails_helper'

RSpec.describe User, type: :model do

  describe '.phone_number' do
    it 'defaults to unverified' do
      expect(subject).not_to be_phone_number_verified
    end

    it 'formats after save' do
      subject = build(:user, phone_number: '(123)-456-7890')
      subject.save!

      expect(subject.reload.phone_number).to eq('1234567890')
    end
  end

  describe '.horses' do
    it { is_expected.to have_many(:horses).dependent(:destroy) }
  end
end
