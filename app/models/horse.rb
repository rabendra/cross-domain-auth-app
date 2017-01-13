class Horse < ApplicationRecord
  belongs_to :user, required: true, inverse_of: :horses

  COMPETITION_TYPES = %w(undefined_type).freeze

  validates :name, :breed, presence: true

  mount_uploader :photo, HorseUploader

  enum competition_type: COMPETITION_TYPES
end
