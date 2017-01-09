require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject { build(:personal_profile) }

  it { is_expected.to have_one(:address) }

  describe '.user' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to validate_presence_of(:user).with_message('must exist') }
  end

  it { is_expected.to validate_presence_of(:first_name) }
end
