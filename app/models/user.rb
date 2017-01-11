class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :horses, inverse_of: :user, dependent: :destroy
  has_one :profile, inverse_of: :user, dependent: :destroy

  attr_accessor :user_token

  # Override to send all email notifications via ActiveJob
  def send_devise_notification(notification, *args)
   devise_mailer.send(notification, self, *args).deliver_later
  end

  def name
    profile.try(:name)
  end

  def format_phone_number
    if self.phone_number
      self.phone_number = self.phone_number.gsub(/[^0-9]/, '')
    end
  end

  def token_payload
    {
        user_id: id,
        email: email
    }
  end
end
