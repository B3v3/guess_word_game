class GameRoom < ApplicationRecord
  extend FriendlyId
    friendly_id :name, use: :slugged

  after_initialize :get_random_word

  belongs_to :word
  has_many :guesses,    dependent: :destroy

  default_scope { order(status: 'ASC') }

  validates :name, presence: true, length: { minimum: 3, maximum: 64}
  validates :description, presence: true, length: { minimum: 3, maximum: 256}
  validates :status, presence: true

  def end_game
    self.update_columns(status: 1)
  end

  def won?
    self.status == 1
  end

  protected
    def get_random_word
      self.word_id = Word.ids.sample if self.new_record?
    end
end
