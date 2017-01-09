require 'rails_helper'

RSpec.describe Address, type: :model do
  it { is_expected.to belong_to(:addressable) }

  context 'in USA' do
    subject { build :address }

    it { is_expected.to validate_presence_of(:state) }
  end

  context 'outside USA' do
    subject { build :address, country: "CA" }

    it { should_not validate_presence_of(:state) }
  end
end
