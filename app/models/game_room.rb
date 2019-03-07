class GameRoom < ApplicationRecord
  extend FriendlyId
    friendly_id :name, use: :slugged

    validates :name, presence: true, length: { minimum: 3, maximum: 64}
end
