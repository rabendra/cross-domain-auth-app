require 'rails_helper'

RSpec.describe Horse, type: :model do
  describe '.user' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to validate_presence_of(:user).with_message('must exist') }
  end

  it { is_expected.to validate_presence_of(:name) }
end
