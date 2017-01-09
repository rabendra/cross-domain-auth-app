class Horse < ApplicationRecord
  belongs_to :user, required: true, inverse_of: :horses

  COMPETITION_TYPES = %w(undefined_type).freeze
  BREED_TYPES = %w(undefined_breed).freeze

  validates :name, presence: true

  mount_uploader :photo, HorseUploader

  enum competition_type: COMPETITION_TYPES
  enum breed: BREED_TYPES
end
