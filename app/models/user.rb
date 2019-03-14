class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   has_many :game_rooms,    dependent: :destroy
   has_many :won_games, class_name: 'GameRoom', foreign_key: 'winner_id'

   has_many :guesses,    dependent: :destroy

   validates :name, presence: true, length: { minimum: 4, maximum: 24},
                    uniqueness: { case_sensitive: false }

  def reward
    self.update_columns(score: (self.score + 10))
  end
end
