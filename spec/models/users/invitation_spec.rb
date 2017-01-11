require 'rails_helper'

RSpec.describe Users::Invitation, type: :model do
  it { is_expected.to belong_to(:requestor).class_name(User.name) }
  it { is_expected.to validate_presence_of(:requestor).with_message('must exist') }

  it { is_expected.to validate_presence_of(:email) }
end
