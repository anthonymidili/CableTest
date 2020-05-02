class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :content, presence: true

  default_scope { order(created_at: :desc) }
end
