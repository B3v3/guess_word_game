class Word < ApplicationRecord
  has_many :game_rooms, dependent: :destroy

  validates :name, presence: true, length: { minimum: 5, maximum: 32},
                   uniqueness: { case_sensitive: false }
end
