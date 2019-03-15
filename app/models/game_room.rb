class GameRoom < ApplicationRecord
  extend FriendlyId
    friendly_id :name, use: :slugged

  after_initialize :get_random_word

  belongs_to :word
  belongs_to :user

  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id', optional: true
  has_many :guesses,    dependent: :destroy

  default_scope { order(status: 'ASC') }

  validates :name, presence: true, length: { minimum: 3, maximum: 64}
  validates :description, presence: true, length: { minimum: 3, maximum: 256}
  validates :status, presence: true

  def end_game(winner)
    self.update_columns(status: 1, winner_id: winner.id)
    self.user.reward; winner.reward
  end

  def won?
    self.status == 1
  end

  def full_name
    self.name + "#{' [CLOSED]' if self.won?}"
  end

  protected
  def get_random_word
    self.word_id = Word.ids.sample if self.word_id.nil?
  end
end
