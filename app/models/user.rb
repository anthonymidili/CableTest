class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :rooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  scope :other_users, -> (user) { where.not(id: user) }

  def send_messages(message, room)
    # "self" is the current_user.
    User.other_users(self).each do |user|
      SendMessageJob.perform_later(user, message, room)
    end
  end

  def last_digit
    id.digits[0]
  end
end
