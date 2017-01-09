require 'rails_helper'

RSpec.describe User, type: :model do

  describe '.phone_number' do
    it 'defaults to unverified' do
      expect(subject).not_to be_phone_number_verified
    end
  end
end
