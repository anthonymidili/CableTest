class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # current room user is in.
  belongs_to :room, optional: true

  has_many :rooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  scope :other_users, -> (user) { where.not(id: user) }

  def send_broadcast(room, message)
    # "self" is the current_user.
    SendMessageJob.perform_later(room, message, self)
  end

  def last_digit
    id.digits[0]
  end
end
