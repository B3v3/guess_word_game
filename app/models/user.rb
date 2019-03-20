class User < ApplicationRecord
   has_many :game_rooms,    dependent: :destroy
   has_many :won_games, class_name: 'GameRoom', foreign_key: 'winner_id'

   has_one :admin

   has_many :guesses,    dependent: :destroy

   validates :name, presence: true, length: { minimum: 4, maximum: 24},
                    uniqueness: { case_sensitive: false }


   # Include default devise modules. Others available are:
   # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

  def reward
    self.update_columns(score: (self.score + 10))
  end

  def is_admin?
    !self.admin.nil?
  end

  def set_as_admin
    Admin.create(user_id: self.id) unless self.is_admin?
  end
end
